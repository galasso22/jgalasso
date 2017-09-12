#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_application_initialization


include_recipe 'iis'

if Opscode::IIS::Helper.older_than_windows2008r2?
  log 'Application Initialization module is not supported on Windows 2008 or lower, ignoring'
else
  windows_feature 'IIS-ApplicationInit' do
    action :install
  end
end
