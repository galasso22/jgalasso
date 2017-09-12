#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_auth_windows

#

include_recipe 'iis'

feature = if Opscode::IIS::Helper.older_than_windows2008r2?
            'Web-Windows-Auth'
          else
            'IIS-WindowsAuthentication'
          end

windows_feature feature do
  action :install
end

iis_section 'unlocks windows authentication control in web.config' do
  section 'system.webServer/security/authentication/windowsAuthentication'
  action :unlock
end
