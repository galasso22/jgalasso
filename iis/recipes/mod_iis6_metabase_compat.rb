#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_iis6_metabase_compat

include_recipe 'iis'

features = if Opscode::IIS::Helper.older_than_windows2008r2?
             %w(Web-Mgmt-Compat Web-Metabase)
           else
             %w(IIS-IIS6ManagementCompatibility IIS-Metabase)
           end

features.each do |f|
  windows_feature f do
    action :install
  end
end
