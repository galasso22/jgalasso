#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_security


include_recipe 'iis'

features = if Opscode::IIS::Helper.older_than_windows2008r2?
             %w(Web-Url-Auth Web-Filtering Web-IP-Security)
           else
             %w(IIS-URLAuthorization IIS-RequestFiltering IIS-IPSecurity)
           end

features.each do |feature|
  windows_feature feature do
    action :install
  end
end
