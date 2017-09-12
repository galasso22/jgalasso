#
# Author:: JGalasso
# Cookbook:: iis


include_recipe 'iis'

features = if Opscode::IIS::Helper.older_than_windows2008r2?
             %w(Web-ISAPI-Filter Web-ISAPI-Ext)
           else
             %w(IIS-ISAPIFilter IIS-ISAPIExtensions)
           end

features.each do |feature|
  windows_feature feature do
    action :install
  end
end
