<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.hosts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.nexon-vms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM Instance Profile to launch the instance with. | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The AMI from which to launch the instance. | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance. | `map(any)` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key name to use for the instance | `string` | n/a | yes |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | A list of elastic load balancer names to add to the autoscaling group names. | `list(any)` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the Auto Scaling Group. | `string` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the Auto Scaling Group. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Prefix used to create resource names. | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of security group IDs to associate | `list(any)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The application deployment stage. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet ID to associate. | `string` | `""` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The base64-encoded user data to provide when launching the instance. | `string` | `null` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size of the volume in gigabytes. | `string` | n/a | yes |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2). | `string` | `""` | no |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in. | `list(any)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->