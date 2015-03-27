require_relative 'spec_helper'

describe 'test_discovery::compile_time' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['discovery']) do |node, server|
      n = stub_node(platform: 'ubuntu', version: '12.04') do |stubnode|
        stubnode.set['tags'] = ['redis', 'sentinel']
      end
      server.create_node(n)
    end.converge(described_recipe)
  end

  it 'should search for a redis sentinel' do
    expect(chef_run).to search_discovery('find a redis sentinel')
    expect(chef_run.node.run_state['discovery_find a redis sentinel']).to eq(['10.0.0.2'])
  end
end
