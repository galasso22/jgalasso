#
# Author:: JGalasso
# Cookbook Name:: firewall
# Recipe:: disable_firewall

# Disable platform default firewall
firewall 'default' do
  action :disable
end
