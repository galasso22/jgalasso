#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_aspnet45

#

include_recipe 'iis'
include_recipe 'iis::mod_isapi'

features = if Opscode::IIS::Helper.older_than_windows2008r2?
             %w(NET-Framework)
           else
             %w(NetFx4Extended-ASPNET45 IIS-NetFxExtensibility45 IIS-ASPNET45)
           end

features.each do |feature|
  windows_feature feature do
    action :install
  end
end
