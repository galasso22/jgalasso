#
# Author:: JGalasso
# Cookbook:: iis

include_recipe 'iis'

features = if Opscode::IIS::Helper.older_than_windows2008r2?
             %w(Web-Mgmt-Console Web-Mgmt-Service)
           else
             %w(IIS-ManagementConsole IIS-ManagementService)
           end

features.each do |feature|
  windows_feature feature do
    action :install
    all !Opscode::IIS::Helper.older_than_windows2012?
  end
end
