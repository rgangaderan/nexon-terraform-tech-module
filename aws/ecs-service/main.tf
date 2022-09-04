locals {
  name_prefix = "${var.name}-${var.stage}"
}

resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  number  = false
}
###################################################
# ECS Cluster
###################################################
resource "aws_ecs_cluster" "cluster" {
  name = "${local.name_prefix}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

###################################################
# ECS Service
###################################################
resource "aws_ecs_service" "fargate" {
  name            = "${local.name_prefix}-${random_string.random.result}"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_df.arn
  desired_count   = var.ecs_configuration.general_configuration.desired_count
  launch_type     = var.ecs_configuration.general_configuration.launch_type
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${local.name_prefix}-${random_string.random.result}"
    container_port   = var.ecs_configuration.ports.container_port
  }
}

###################################################
# ECS Task Definition
###################################################
resource "aws_ecs_task_definition" "task_df" {
  family                   = "${local.name_prefix}-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_configuration.general_configuration.cpu
  memory                   = var.ecs_configuration.general_configuration.memory
  container_definitions    = <<TASK_DEFINITION
  [
    {
      "name": "${local.name_prefix}",
      "image": "${var.ecs_configuration.general_configuration.image}",
      "environment": [
        {
          "name": "VARNAME", 
          "value": "VARVAL"
        },
        {
        "name": "VARNAME", 
        "value": "VARVAL"
        }
      ]
    }
]
TASK_DEFINITION
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}