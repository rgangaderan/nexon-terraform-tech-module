<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_limit"></a> [az\_limit](#input\_az\_limit) | The absolute limit for Availability Zones. The default is ok for most cases.<br>The variable is only here for future use (and for us-east-1). | `number` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR of the VPC. | `string` | n/a | yes |
| <a name="input_cidr_num_bits"></a> [cidr\_num\_bits](#input\_cidr\_num\_bits) | Cidr num bits to create subnets. | `number` | n/a | yes |
| <a name="input_max_azs"></a> [max\_azs](#input\_max\_azs) | The number of AZs you want to use in the VPC. Only values less than 'az\_limit' and the number of available Zones in the Region are honored.<br>The number of the configured AZs will always be the lesser of the 3 values." | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the ECR repository to manage. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Defalut region. | `string` | n/a | yes |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The application deployment stage. | `string` | n/a | yes |
| <a name="input_vpc_tag_info"></a> [vpc\_tag\_info](#input\_vpc\_tag\_info) | A map of tags to assign to the resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_az_count"></a> [az\_count](#output\_az\_count) | The number of  Availability Zones used for the VPC. |
| <a name="output_azs"></a> [azs](#output\_azs) | The Availability Zone names used for the VPC. |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | A list of public IPs associated with the NAT gateways created in the VPC. |
| <a name="output_private_cidr"></a> [private\_cidr](#output\_private\_cidr) | The network range used to create the private subnets in the VPC. |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | A list of private route table IDs created in the VPC. |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | A list of private subnet CIDRs created in the VPC. |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | A list of private subnet IDs created in the VPC. |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | A list of public route table IDs created in the VPC. |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | A list of public subnet CIDRs created in the VPC. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | A list of public subnet IDs created in the VPC. |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR range of the VPC. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
<!-- END_TF_DOCS -->