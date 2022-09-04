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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket_for_logs"></a> [s3\_bucket\_for\_logs](#module\_s3\_bucket\_for\_logs) | terraform-aws-modules/s3-bucket/aws | ~> 2.14.1 |

## Resources

| Name | Type |
|------|------|
| [aws_alb.this_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.http_listener_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_lb_target_group.instance_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ips"></a> [allowed\_ips](#input\_allowed\_ips) | A list of IPs allowed to access loadbalancer. | `list(string)` | n/a | yes |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | `map(string)` | <pre>{<br>  "healthy_threshold": "3",<br>  "interval": "20",<br>  "path": "/",<br>  "port": "80",<br>  "timeout": "10",<br>  "unhealthy_threshold": "2"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Prefix used to create resource names. | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | An object describing the AWS VPC network and subnet | <pre>object({<br>    vpc_id            = string<br>    public_subnet_ids = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of security group IDs to assign to the ELB | `list(string)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The application deployment stage. | `string` | `"development"` | no |
| <a name="input_tag_info"></a> [tag\_info](#input\_tag\_info) | A map of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of target that you must specify when registering targets with this target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_lb"></a> [application\_lb](#output\_application\_lb) | An object describing the central load balancer of the environment |
| <a name="output_listeners"></a> [listeners](#output\_listeners) | An object describing the listeners attached to the load balancer |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | A list of security group IDs to assign to the application load balancer. |
| <a name="output_target_group_arns"></a> [target\_group\_arns](#output\_target\_group\_arns) | ARN of the Target Group |
<!-- END_TF_DOCS -->