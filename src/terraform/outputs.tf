output "parent" {
  description = "The resource name of the parent Folder or Organization of the top level folder. Its format is folders/{folder_id} or organizations/{org_id}."
  value       = google_folder.top_level.parent
}

output "top_level_folder" {
  description = "The resource name of the Folder. Its format is folders/{folder_id}."
  value       = google_folder.top_level.name
}

output "environment_folders" {
  description = "A list of the environment folders resource names and display names. Its format is [{name: folders/{folder_id}, display_name: 'Display Name'}, ...]"
  value = [for folder in google_folder.environment : {
    name         = folder.name,
    display_name = folder.display_name
  }]
}

output "team_folders" {
  description = "A list of the team folders resource names. Its format is [{name: folders/{folder_id}, display_name: 'Display Name', parent: folders/{folder_id}}, ...]"
  value = [for folder in google_folder.team : {
    name         = folder.name,
    display_name = folder.display_name
    parent       = folder.parent
    parent_name  = values(google_folder.environment)[index([for v in values(google_folder.environment) : v.name], folder.parent)].display_name
  }]
}
