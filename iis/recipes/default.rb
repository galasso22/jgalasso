#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: default


# Always add this, so that we don't require this to be added if we want to add other components
default = Opscode::IIS::Helper.older_than_windows2008r2? ? 'Web-Server' : 'IIS-WebServerRole'

([default] + node['iis']['components']).each do |feature|
  windows_feature feature do
    action :install
    all !Opscode::IIS::Helper.older_than_windows2012?
    source node['iis']['source'] unless node['iis']['source'].nil?
  end
end

service 'iis' do
  service_name 'W3SVC'
  action [:enable, :start]
end
