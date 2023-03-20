variable "org_id" {
  description = "The organization ID under which the folders will be created."
  type        = string
}

variable "top_level_folder_name" {
  description = "The name of the top level folder to create. Other folders will be nested under this one."
  type        = string
}

variable "environment_folder_names" {
  description = "The environment folders to create e.g. dev, test, prod, etc. These folders will be children of the top level folder."
  type        = set(string)
}

variable "team_folder_names" {
  description = "The team folders to create. These folders will be children of the environment folders and will be repeated across each environment."
  type        = set(string)
}
