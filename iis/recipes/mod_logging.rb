#
# Author:: JGalasso
# Cookbook:: iis


include_recipe 'iis'

feature = if Opscode::IIS::Helper.older_than_windows2008r2?
            'Web-Http-Logging'
          else
            'IIS-CustomLogging'
          end

windows_feature feature do
  action :install
end
