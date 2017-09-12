#
# Cookbook:: iis
# Resource:: config
#

include Opscode::IIS::Helper
include Opscode::IIS::Processors

property    :cfg_cmd,   String,             name_attribute: true
property    :returns,   [Integer, Array],   default: 0

default_action :set

action :set do
  config
end

action :clear do
  config(:clear)
end

action_class.class_eval do
  def config(action = :set)
    converge_by "Executing IIS Config #{action}" do
      cmd = "#{appcmd(node)} #{action} config #{new_resource.cfg_cmd}"
      Chef::Log.debug(cmd)
      shell_out!(cmd, returns: new_resource.returns)
    end
  end
end
