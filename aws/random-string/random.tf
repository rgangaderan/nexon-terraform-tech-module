###############################################################################
# Random will create some string with added conditions and will use to create 
# name-prefix to avoid duplicate resource error
###############################################################################
resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  numeric = false
}
