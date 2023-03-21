# frozen_string_literal: true

title 'Folder Structure'

parent_id = input('parent_id')
top_level_folder_name = input('top_level_folder_name')
environment_folder_names = input('environment_folder_names')
team_folder_names = input('team_folder_names')

control 'gcp-folder-structure-1.0' do
  impact 1.0
  title 'Ensure the folder structure is deployed correctly.'
  desc 'This test requires that the top level folder is the only folder under the parent
    and that there are 1..n environment folders under the top level folder and
    that each environment folder has the same set of team folders (again 1..n) as child folders.'

  # Test that the parent only has a single top level folder
  describe google_resourcemanager_folders(parent: parent_id).display_names do
    its(:size) { should eq 1 }
  end

  # Get top level folder under parent
  google_resourcemanager_folders(parent: parent_id).names.each do |top_level_folder|
    # Test for the top level folder
    describe google_resourcemanager_folder(name: top_level_folder) do
      it { should exist }
      its('display_name') { should eq top_level_folder_name }
    end

    # Test that the top level folder has the correct number of environment folders
    describe google_resourcemanager_folders(parent: top_level_folder).display_names do
      its(:size) { should eq environment_folder_names.length }
    end

    # Get environment folders under top level folder
    google_resourcemanager_folders(parent: top_level_folder).names.each do |environment_folder|
      # Test environment folder
      describe google_resourcemanager_folder(name: environment_folder) do
        it { should exist }
        its('display_name') { should be_in environment_folder_names }
      end

      # Test that each environment folder has the correct number of team folders
      describe google_resourcemanager_folders(parent: environment_folder).display_names do
        its(:size) { should eq team_folder_names.length }
      end

      # Get team folders under environment folder
      google_resourcemanager_folders(parent: environment_folder).names.each do |team_folder|
        # Test Team Folder
        describe google_resourcemanager_folder(name: team_folder) do
          it { should exist }
          its('display_name') { should be_in team_folder_names }
        end
      end
    end
  end
end
