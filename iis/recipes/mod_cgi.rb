#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_cgi

#

include_recipe 'iis'

feature = if Opscode::IIS::Helper.older_than_windows2008r2?
            'Web-CGI'
          else
            'IIS-CGI'
          end

windows_feature feature do
  action :install
end
