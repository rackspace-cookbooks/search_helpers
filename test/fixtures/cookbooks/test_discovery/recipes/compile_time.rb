include_recipe 'chef-sugar'

discovery 'find a redis sentinel' do
  tags ['redis', 'sentinel']
  block do |node|
    node_ip = best_ip_for(node)
    Chef::Log.warn("#{node.name} was found as a redis sentinel at #{node_ip}")
    node_ip
  end
  action :nothing
end.run_action(:search) # now we're at compile time!

# since we ran the action at compile time, we have this data available,
# but this won't work in a unit test where discovery isn't stepped into
if node.run_state && node.run_state['discovery_find a redis sentinel']
  rs = node.run_state['discovery_find a redis sentinel']
  Chef::Log.warn("All nodes found: #{rs.join(',')}") if rs
end
