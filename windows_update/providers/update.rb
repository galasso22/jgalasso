#
# Author:: JGalasso via BCourtois
# Cookbook Name:: windows_update
# Provider:: update

use_inline_resources

def whyrun_supported?
  true
end

def load_current_resource
  require 'win32ole'
end

action :download do
  updates_to_download = updates.reject(&:IsDownloaded)
  if updates_to_download.count != 0
    Chef::Log.info "Windows Auto Update: #{updates_to_download.count} update(s) to download."
    converge_by "downloading #{updates_to_download.count} update(s)" do
      # Transforms to a new update collection
      update_collection = WIN32OLE.new('Microsoft.Update.UpdateColl')
      updates_to_download.each { |update| update_collection.Add update }
      # Performs download
      downloader = session.CreateUpdateDownloader
      downloader.Updates = update_collection
      # Verifies operation result
      assert_result 'Download', downloader.Download
    end
  end
end

action :install do
  downloaded_updates = updates.select(&:IsDownloaded)
  if downloaded_updates.count != 0
    Chef::Log.info "Windows Auto Update: #{downloaded_updates.count} update(s) to install."
    converge_by "installing #{downloaded_updates.count} update(s)" do
      # Transforms to a new update collection
      update_collection = WIN32OLE.new('Microsoft.Update.UpdateColl')
      downloaded_updates.each do |update|
        unless update.EulaAccepted
          converge_by "accepting EULA for #{update.Title}" do
            update.AcceptEula
          end
        end
        update_collection.Add update
      end
      # Performs install
      installer = session.CreateUpdateInstaller
      installer.ForceQuiet = true
      installer.Updates = update_collection
      # Verifies operation result
      assert_result 'Installation', installer.Install
    end
  end
end

private

# ResultCode values: http://msdn.microsoft.com/aa387095
SUCCESS_CODE = 2
def assert_result(action, result)
  return unless result.HResult != 0 || result.ResultCode != SUCCESS_CODE
  fail "#{action} failed. (Error code #{result.HResult})"
end

def updates
  node.run_state['wsus_client_updates'] ||= [].tap do |updates|
    # Searches non installed updates
    search_result = session.CreateUpdateSearcher.Search 'IsInstalled=0'
    # Transforms to ruby array for future use
    search_result.Updates.each { |update| updates << update }
  end
end

def session
  @session ||= WIN32OLE.new('Microsoft.Update.Session')
end
