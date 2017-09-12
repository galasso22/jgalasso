#
# Author:: JGalasso 
# Cookbook Name:: windows_update
# Recipe:: default
#
# WSUS is a windows only feature
return unless platform?('windows')

include_recipe 'wsus-client::update'
