#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_auth_basic
#


include_recipe 'iis'

iis_section 'unlocks anonymous authentication control in web.config' do
  section 'system.webServer/security/authentication/anonymousAuthentication'
  action :unlock
end
