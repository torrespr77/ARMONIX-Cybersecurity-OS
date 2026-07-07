# Skill: Cloud Security — AWS

## Descripción
Guía de seguridad para infraestructura en Amazon Web Services (AWS), incluyendo IAM, Security Groups, VPC, logging, monitoreo y mejores prácticas para clientes de BRIDA IT Services.

## Cuándo Usar
- Clientes migrando a AWS o ya en AWS
- Configuración de seguridad inicial de cuenta AWS
- Auditoría de seguridad de infraestructura cloud
- Implementación de controles de seguridad en AWS
- Incident response en entorno AWS

## Modelo de Responsabilidad Compartida

```
┌─────────────────────────────────────────┐
│           RESPONSABILIDAD DEL CLIENTE    │
│  (Security IN the Cloud)                │
│  - IAM policies & users                 │
│  - Security Groups & NACLs              │
│  - Data encryption                      │
│  - OS patching on EC2                   │
│  - Application security                 │
│  - Network configuration                │
├─────────────────────────────────────────┤
│           RESPONSABILIDAD DE AWS         │
│  (Security OF the Cloud)                │
│  - Physical data centers                │
│  - Hardware infrastructure              │
│  - Network infrastructure               │
│  - Hypervisor                           │
└─────────────────────────────────────────┘
```

## Configuración Inicial de Seguridad AWS

### 1. Root Account Protection
```bash
# El root account NUNCA debe usarse para operaciones diarias
# 1. Crear un usuario IAM admin
# 2. Habilitar MFA en el root account (hardware key preferido)
# 3. Eliminar access keys del root account
# 4. Configurar alertas de uso del root account
```

### 2. IAM (Identity and Access Management)

#### Principio de Menor Privilegio
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::company-data-bucket",
        "arn:aws:s3:::company-data-bucket/*"
      ],
      "Condition": {
        "IpAddress": {"aws:SourceIp": "10.0.0.0/8"},
        "Bool": {"aws:MultiFactorAuthPresent": "true"}
      }
    }
  ]
}
```

#### Estructura de Usuarios Recomendada
| Rol | Permisos | MFA |
|---|---|---|
| **Root** | Solo emergencias | ✅ Hardware key |
| **Admin** | Full admin (no billing) | ✅ |
| **SecurityAdmin** | Security services only | ✅ |
| **Dev** | EC2, S3, RDS (dev env) | ✅ |
| **ReadOnly** | Read-only access | ✅ |
| **ServiceAccounts** | Specific API permissions | N/A (API keys) |

#### Políticas Obligatorias
```
- Password policy: min 14 chars, symbols, numbers, uppercase
- MFA required for all IAM users
- Access keys rotated every 90 days
- Unused credentials disabled after 45 days
- No inline policies (use managed policies)
```

### 3. VPC (Virtual Private Cloud)

#### Arquitectura VPC Recomendada
```
┌──────────────────────────────────────────────────────────┐
│  VPC: 10.0.0.0/16                                        │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  Public Subnet: 10.0.1.0/24                         │ │
│  │  - NAT Gateway                                       │ │
│  │  - Bastion Host (Jump Server)                        │ │
│  │  - Load Balancer                                     │ │
│  └─────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  Private Subnet (App): 10.0.2.0/24                  │ │
│  │  - EC2 instances (application servers)               │ │
│  │  - ECS/EKS containers                                │ │
│  └─────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────┐ │
│  │  Private Subnet (Data): 10.0.3.0/24                 │ │
│  │  - RDS databases                                     │ │
│  │  - ElastiCache                                       │ │
│  │  - No internet access                                │ │
│  └─────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────┘
```

#### Security Groups (Firewall a nivel de instancia)
```
# Web Server Security Group
Inbound:
  - TCP 443 from 0.0.0.0/0 (HTTPS)
  - TCP 80 from 0.0.0.0/0 (HTTP → redirect to HTTPS)
  - TCP 22 from 10.0.1.0/24 (SSH only from bastion)
Outbound:
  - TCP 443 to 10.0.3.0/24 (to database)
  - TCP 443 to 0.0.0.0/0 (updates, APIs)

# Database Security Group
Inbound:
  - TCP 3306 from 10.0.2.0/24 (MySQL from app servers only)
  - TCP 5432 from 10.0.2.0/24 (PostgreSQL from app servers only)
Outbound:
  - None (no outbound needed)

# Bastion Host Security Group
Inbound:
  - TCP 22 from [Office IP]/32 (SSH from corporate only)
Outbound:
  - TCP 22 to 10.0.2.0/24 (SSH to private instances)
```

#### NACLs (Network ACLs) — Firewall a nivel de subnet
```
# Public Subnet NACL
Inbound: Allow 80, 443 from 0.0.0.0/0 | Allow 22 from [Office IP]
Outbound: Allow 80, 443 to 0.0.0.0/0 | Allow 1024-65535 to VPC

# Private Subnet NACL
Inbound: Allow 3306, 5432 from 10.0.2.0/24 | Allow 1024-65535 from 0.0.0.0/0
Outbound: Allow 443 to 0.0.0.0/0 | Allow 1024-65535 to VPC
```

### 4. Logging y Monitoreo

#### CloudTrail (Auditoría de API)
```
- Habilitar en TODAS las regiones
- Log file validation habilitado
- Enviar logs a S3 bucket con encryption
- Enviar a CloudWatch Logs para monitoreo
- Retención: mínimo 365 días
```

#### VPC Flow Logs
```
- Habilitar en todas las VPCs
- Destino: CloudWatch Logs o S3
- Formato: campos personalizados para análisis
- Retención: mínimo 90 días
```

#### GuardDuty (Threat Detection)
```
- Habilitar en todas las regiones
- Findings automáticos:
  - CryptoCurrency mining
  - Unauthorized access
  - Instance compromise
  - Reconnaissance activity
- Enviar findings a SNS → Email/Slack
```

#### AWS Config
```
- Habilitar configuration recorder
- Rules recomendadas:
  - s3-bucket-public-read-prohibited
  - s3-bucket-ssl-requests-only
  - iam-user-no-policies-check
  - ec2-instance-no-public-ip
  - rds-instance-public-access-check
  - cloud-trail-encryption-enabled
  - ebs-encryption-by-default
```

### 5. Protección de Datos

#### Encryption at Rest
```
- EBS volumes: encryption habilitada por default
- S3 buckets: SSE-S3 o SSE-KMS encryption
- RDS: encryption at rest habilitada
- S3 bucket policy: deny unencrypted uploads
```

#### Encryption in Transit
```
- TLS 1.2+ para todos los servicios
- Certificate Manager (ACM) para certificados SSL
- ALB/NLB con HTTPS listeners
- RDS con SSL connections
```

#### S3 Security
```
- Block public access (account-level)
- Bucket policies restrictivas
- Versioning habilitado
- MFA Delete habilitado
- Access logging habilitado
- Lifecycle policies para datos antiguos
```

### 6. AWS WAF (Web Application Firewall)
```
# Reglas recomendadas para aplicaciones web:
- AWS Managed Rules:
  - Common Rule Set (CRS)
  - Known Bad Inputs
  - SQL Injection
  - Linux OS
  - PHP Application
  - WordPress
- Rate limiting: 2000 requests/5min per IP
- IP reputation lists
- Geo-blocking (si aplica)
- Integración con CloudFront y ALB
```

### 7. Incident Response en AWS

#### Detección
- GuardDuty findings → SNS → Alerta
- CloudWatch Alarms → Métricas anómalas
- CloudTrail → Actividad sospechosa
- VPC Flow Logs → Tráfico anómalo

#### Contención
```bash
# Aislar instancia comprometida
aws ec2 modify-instance-attribute --instance-id i-xxx --groups sg-isolation

# Revocar credenciales comprometidas
aws iam update-access-key --access-key-id AKIA... --status Inactive

# Bloquear IP maliciosa
aws wafv2 update-ip-set --name blocklist --addresses x.x.x.x/32

# Snapshot de instancia para forenses
aws ec2 create-snapshot --volume-id vol-xxx --description "Forensic snapshot"
```

## Checklist de Seguridad AWS
- [ ] Root account con MFA hardware y sin access keys
- [ ] IAM users con principio de menor privilegio
- [ ] MFA habilitado para todos los usuarios
- [ ] Password policy fuerte (14+ chars)
- [ ] VPC con subnets públicas/privadas separadas
- [ ] Security Groups restrictivos (no 0.0.0.0/0)
- [ ] NACLs configurados por subnet
- [ ] CloudTrail habilitado en todas las regiones
- [ ] VPC Flow Logs habilitados
- [ ] GuardDuty activo
- [ ] AWS Config con rules habilitadas
- [ ] Encryption at rest (EBS, S3, RDS)
- [ ] Encryption in Transit (TLS 1.2+)
- [ ] S3 public access blocked
- [ ] WAF configurado para aplicaciones web
- [ ] Backup y DR plan documentado
- [ ] Incident response plan para AWS
