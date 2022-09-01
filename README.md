# nexon-terraform-tech-module

<!-- BEGIN_TF_DOCS -->
nexon-terraform-tech-module
Technology module is root module for all other modules where you will have and create all your resources. From this module we cannot deploy anything on AWS account instead you have to call this module from Business module in 
https://github.com/rgangaderan/nexon-terraform-business-module

EX: Assume you need to create a Web Application running on EC2 Autoscaling with AWS Application Load balancer. You will create the main modules in this repository, and it can be callable from any other module as source

<!-- END_TF_DOCS -->
