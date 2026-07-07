# Análisis de Certificados TLS/HTTPS — Guía OSINT

## Comandos esenciales

### Datos clave del certificado
```bash
echo | openssl s_client -servername DOMINIO -connect DOMINIO:443 2>/dev/null | openssl x509 -noout -subject -issuer -dates -ext subjectAltName
```

### Protocolo y cipher negociado
```bash
echo | openssl s_client -servername DOMINIO -connect DOMINIO:443 2>/dev/null | grep -E "Protocol|Cipher|Verify"
```

### Protocolos soportados (test individual)
```bash
for proto in tls1 tls1_1 tls1_2 tls1_3; do
  echo "[$proto]"
  echo | openssl s_client -servername DOMINIO -connect DOMINIO:443 -$proto 2>&1 | grep "Protocol\|Cipher\|Verify"
done
```

### Certificados de subdominios
```bash
for sub in www careers contenido facturacion credito devoluciones mi; do
  echo "=== $sub.DOMINIO ==="
  echo | openssl s_client -servername $sub.DOMINIO -connect $sub.DOMINIO:443 2>/dev/null | openssl x509 -noout -subject -issuer -dates -ext subjectAltName 2>/dev/null
done
```

### Headers de seguridad HTTP
```bash
curl -sI https://www.DOMINIO 2>/dev/null
```

## Headers de seguridad a verificar

| Header | Valor esperado | Severidad si falta |
|---|---|---|
| Strict-Transport-Security | max-age=31536000; includeSubDomains; preload | ALTA |
| Content-Security-Policy | frame-ancestors, default-src, script-src | MEDIA |
| X-Content-Type-Options | nosniff | MEDIA |
| X-Frame-Options | DENY o SAMEORIGIN | MEDIA |
| X-XSS-Protection | 1; mode=block | BAJA |
| Referrer-Policy | strict-origin-when-cross-origin | BAJA |
| Permissions-Policy | camera=(), microphone=() | BAJA |
| Cache-Control | no-cache, no-store (contenido sensible) | MEDIA |

## Checklist de certificados

- [ ] Tipo (DV, OV, EV)
- [ ] Emisor (CA)
- [ ] Fecha de expiración y días restantes
- [ ] Subject Alternative Names (SANs)
- [ ] Algoritmo de firma (SHA-256 mínimo)
- [ ] Tamaño de clave (RSA 2048+ mínimo)
- [ ] Protocolos TLS soportados (1.2 y 1.3)
- [ ] Cipher suites
- [ ] Certificate Transparency (SCTs)
- [ ] Todos los subdominios con certificado válido

## Hallazgos comunes y severidad

| Hallazgo | Severidad |
|---|---|
| Cert expira en < 90 días | CRITICO |
| Subdominios sin cert TLS | CRITICO |
| Sin HSTS | ALTO |
| TLS 1.0/1.1 habilitado | ALTO |
| Cert autofirmado en producción | ALTO |
| Mezcla de CAs sin justificación | MEDIO |
| CSP incompleto | MEDIO |
| Headers de seguridad faltantes | MEDIO-BAJO |

## Integración con Threat Model

Cuando se realiza análisis TLS como parte de un Threat Model:

1. **Crear sección dedicada** — "Análisis de Certificados TLS/HTTPS" dentro de la sección de Perfil OSINT
2. **Incluir tabla de subdominios** — Con estado del certificado por cada subdominio
3. **Agregar categoría TLS/Certificados** al análisis STRIDE+DREAD
4. **Escenarios de ataque** — Incluir expiración de cert y subdominios sin TLS como escenarios
5. **Recomendaciones priorizadas** — Renovar cert como Quick Win #1 si expira en < 90 días
