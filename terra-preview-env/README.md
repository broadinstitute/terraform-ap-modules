## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google.dns | n/a |
| google.target | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| google\_project | The google project in which to create resources | `string` | n/a | yes |
| cluster | Terra GKE cluster suffix, whatever is after terra- | `string` | n/a | yes |
| cluster\_short | Optional short cluster name | `string` | `""` | no |
| owner | Environment or developer. Defaults to TF workspace name if left blank. | `string` | `""` | no |
| dns\_zone\_name | DNS zone name | `string` | `"dsp-envs"` | no |
| terra\_apps | Map of app Helm chart names to ingress hostnames | `map(string)` | <pre>{<br>  "workspacemanager": "workspace"<br>}</pre> | no |
| versions | Base64 encoded JSON string of version overrides | `string` | `"Cg=="` | no |

## Outputs

| Name | Description |
|------|-------------|
| ingress\_ips | Service ingress IPs |
| fqdns | Service fully qualified domain names |
| versions | Base64 encoded JSON string of version overrides |
