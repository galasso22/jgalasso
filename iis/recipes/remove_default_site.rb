#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: remove_default_site


iis_site 'Default Web Site' do
  action [:stop, :delete]
end

iis_pool 'DefaultAppPool' do
  action [:stop, :delete]
end
