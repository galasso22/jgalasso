#
# Author:: JGalasso
# Cookbook:: iis
#

include_recipe 'iis'

feature = if Opscode::IIS::Helper.older_than_windows2008r2?
            'Web-Stat-Compression'
          else
            'IIS-HttpCompressionStatic'
          end

windows_feature feature do
  action :install
end
