#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_diagnostics

include_recipe 'iis'

feature = if Opscode::IIS::Helper.older_than_windows2008r2?
            'Web-Http-Tracing'
          else
            'IIS-HTTPTracing'
          end

windows_feature feature do
  action :install
end
