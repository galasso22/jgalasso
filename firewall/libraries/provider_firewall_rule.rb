#
# Author:: JGalasso
# Cookbook Name:: firewall
# Provider:: rule_iptables
#
#
class Chef
  class Provider::FirewallRuleGeneric < Chef::Provider::LWRPBase
    provides :firewall_rule

    def action_create
      return unless new_resource.notify_firewall

      firewall_resource = Chef.run_context.resource_collection.find(firewall: new_resource.firewall_name)
      raise 'could not find a firewall resource' unless firewall_resource

      new_resource.notifies(:restart, firewall_resource, :delayed)
      new_resource.updated_by_last_action(true)
    end
  end
end
