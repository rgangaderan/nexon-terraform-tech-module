<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.69 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.69 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | Password for the master DB user. | `string` | n/a | yes |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | Username for the master DB user. | `string` | n/a | yes |
| <a name="input_db"></a> [db](#input\_db) | Database related Variables. | <pre>object(<br>    {<br>      storage              = string<br>      engine               = string<br>      engine_version       = string<br>      instance_class       = string<br>      database_name        = string<br>      parameter_group_name = string<br>      skip_snapshot        = string<br>      deletion_protection  = string<br>      db_port              = number<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Prefix used to create resource names. | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | Private subnet IDs associate with RDS Instance Subnet Group | `list(any)` | n/a | yes |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | List of DB Security Groups to associate. | `list(any)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The application deployment stage. | `string` | `"development"` | no |
| <a name="input_tag_info"></a> [tag\_info](#input\_tag\_info) | A map of tags to assign to the resource. | `map(any)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->