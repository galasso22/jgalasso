#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_compress_dynamic


include_recipe 'iis'

feature = if Opscode::IIS::Helper.older_than_windows2008r2?
            'Web-Dyn-Compression'
          else
            'IIS-HttpCompressionDynamic'
          end

windows_feature feature do
  action :install
end
