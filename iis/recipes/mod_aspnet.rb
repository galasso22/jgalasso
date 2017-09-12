#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_aspnet

include_recipe 'iis'
include_recipe 'iis::mod_isapi'

features = if Opscode::IIS::Helper.older_than_windows2008r2?
             %w(NET-Framework)
           else
             %w(IIS-NetFxExtensibility IIS-ASPNET)
           end

features.each do |feature|
  windows_feature feature do
    action :install
    all !Opscode::IIS::Helper.older_than_windows2012?
    source node['iis']['source'] unless node['iis']['source'].nil?
  end
end
