#
# Author:: JGalasso
# Cookbook:: iis
# Recipe:: mod_ftp


include_recipe 'iis'

features = if Opscode::IIS::Helper.older_than_windows2008r2?
             %w(Web-Ftp-Server Web-Ftp-Service Web-Ftp-Ext)
           else
             %w(IIS-FTPServer IIS-FTPSvc IIS-FTPExtensibility)
           end

features.each do |f|
  windows_feature f do
    action :install
  end
end
