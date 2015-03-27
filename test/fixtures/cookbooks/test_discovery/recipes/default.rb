include_recipe 'chef-sugar'

discovery 'find a mysql master' do
  tags ['master', 'mysql']
  block do |node|
    node_ip = best_ip_for(node)
    Chef::Log.warn("#{node.name} was found as a mysql master at #{node_ip}")
    node_ip
  end
  action :search
end

# note that in this scope at compile time, node.run_state is not populated yet,
# because chef provider actions don't actually run until convergence!

ruby_block 'log all nodes' do
  block do
    Chef::Log.warn("All nodes found: #{node.run_state['discovery_find a mysql master'].join(',')}")
  end
end
