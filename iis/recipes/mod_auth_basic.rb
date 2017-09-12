#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_auth_basic

#

include_recipe 'iis'

feature = if Opscode::IIS::Helper.older_than_windows2008r2?
            'Web-Basic-Auth'
          else
            'IIS-BasicAuthentication'
          end

windows_feature feature do
  action :install
end

iis_section 'unlocks basic authentication control in web.config' do
  section 'system.webServer/security/authentication/basicAuthentication'
  action :unlock
end
