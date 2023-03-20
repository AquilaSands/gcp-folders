locals {
  team_folders = flatten([
    for name in var.team_folder_names : [
      for env in google_folder.environment : {
        env_folder  = env.name
        team_folder = name
      }
    ]
  ])
}

resource "google_folder" "top_level" {
  display_name = var.top_level_folder_name
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "environment" {
  for_each     = var.environment_folder_names
  display_name = each.value
  parent       = google_folder.top_level.name
}

resource "google_folder" "team" {
  # local.network_subnets is a list, so we must now project it into a map
  # where each key is unique. We'll combine the network and subnet keys to
  # produce a single unique key per instance.
  for_each = {
    for i, folder in local.team_folders : "${i}" => folder
  }

  display_name = each.value.team_folder
  parent       = each.value.env_folder
}
