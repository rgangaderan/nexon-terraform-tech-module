<!-- BEGIN_TF_DOCS -->
<img src="../../../docs/images/nuri-logo.png" align="right" width="200px" />

# Nuri's Terraform Modules

[![Terraform](../../../docs/badges/terraform.svg)][terraform]
[![Conventional Commits](../../../docs/badges/conventional-commits.svg)][conventional-commits]

> Provide high-quality, reusable modules for Nuri's cloud infrastructure

[terraform]: https://www.terraform.io/
[conventional-commits]: https://conventionalcommits.org

## Description
Module to create [ECR][ecr] in [ECS][ecs] with all needed policies to store your docker container in.

#### Important note:
If the account is an non-development account the provider needs to point to the corresponding artifacts account.

[ecr]: https://aws.amazon.com/ecr/
[ecs]: https://aws.amazon.com/ecs/


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.69 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.69 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.ecr_combined_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Example usage
```terraform
module "ecr_repository" {
  source = "git@github.bitwa.la:bitwala-bank-devops/infrastructure-modules//technology/aws/ecr?ref=v5.34.0"

  name = basename(var.git_repository)

  deployment_account_id  = var.platform.workloads_account.deployment_account.id
  workloads_account_name = var.platform.workloads_account.name
  workloads_account_id   = var.platform.workloads_account.id

  providers = {
    aws = aws.artifacts
  }
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlantis_account_id"></a> [atlantis\_account\_id](#input\_atlantis\_account\_id) | The numeric ID of the atlantis AWS account which is allowed to push artifacts into Elastic Container Registry in this account. | `string` | `""` | no |
| <a name="input_deployment_account_id"></a> [deployment\_account\_id](#input\_deployment\_account\_id) | The numeric ID of the AWS account which is allowed to push artifacts into Elastic Container Registry in this account. | `string` | n/a | yes |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | The tag mutability setting for the repository. | `string` | `"MUTABLE"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the ECR repository to manage. | `string` | n/a | yes |
| <a name="input_workloads_account_id"></a> [workloads\_account\_id](#input\_workloads\_account\_id) | The numeric ID of the AWS account which needs to pull images from the ECR. | `string` | n/a | yes |
| <a name="input_workloads_account_name"></a> [workloads\_account\_name](#input\_workloads\_account\_name) | The name of the AWS account which needs to pull images from the ECR. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repo_name"></a> [repo\_name](#output\_repo\_name) | Name of the ECR Repo |
| <a name="output_url"></a> [url](#output\_url) | URL of the ECR |

## License

Copyright &copy; 2021 Bitwala GmbH & Nuri

This project repository contains UNLICENSED, proprietary information. Any
sharing of the information contained herein, beyond our organization, is
strictly prohibited.
<!-- END_TF_DOCS -->