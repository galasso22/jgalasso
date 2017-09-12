#
# Author:: JGalasso 
# Cookbook Name:: windows_update
# Recipe:: update
#
return unless platform?('windows')

if node['wsus_client']['download_only']
  actions_to_perform = [:download]
else
  actions_to_perform = [:download, :install]
end

wsus_client_update 'WSUS updates' do
  action             actions_to_perform
end
