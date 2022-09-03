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
  desired_count   = var.desired_count
  iam_role        = var.iam_role
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
    container_port   = var.task_definition.ports.container_port
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

###################################################
# ECS Task Definition
###################################################
resource "aws_ecs_task_definition" "task_df" {
  family                   = "${local.name_prefix}-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_definition.general_configuration.cpu
  memory                   = var.task_definition.general_configuration.memory
  essential                = true
  container_definitions    = <<TASK_DEFINITION
  [
    {
      "name": "${local.name_prefix}",
      "image": "${var.task_definition.image}",
      "cpu": "${var.task_definition.general_configuration.cpu}",
      "memory": "${var.task_definition.general_configuration.memory}",
      "environment": [
        ${var.env_variable}
      ],
      "essential": true
    }
]
TASK_DEFINITION
  runtime_platform {
    operating_system_family = "Linux"
    cpu_architecture        = "ARM64"
  }


  portMappings = [
    {
      containerPort = var.task_definition.ports.container_port
      hostPort      = var.task_definition.ports.host_port
    }
  ]
}
