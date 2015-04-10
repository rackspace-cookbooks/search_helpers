require_relative 'spec_helper'

# Use these to debug resource names and classes on the chef run
# pp chef_run.resource_collection.map(&:name).join(',')
# pp chef_run.resource_collection.map(&:class).join(',')

describe 'test_discovery::default' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['discovery']) do |node, server|
      n = stub_node(platform: 'ubuntu', version: '12.04') do |stubnode|
        stubnode.set['tags'] = ['mysql', 'master']
      end
      server.create_node(n)
    end.converge(described_recipe)
  end

  it 'should search for a mysql master' do
    expect(chef_run).to search_discovery('find a mysql master')
    expect(chef_run.node.run_state['discovery_find a mysql master']).to eq(['10.0.0.2'])
  end
end
