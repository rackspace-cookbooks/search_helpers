require_relative 'spec_helper'

describe 'test_discovery::add' do
  let(:chef_run) { ChefSpec::ServerRunner.new(step_into: ['discovery']).converge(described_recipe) }

  it 'should tag the node as mysql slave' do
    expect(chef_run).to add_discovery('make a slave')
    expect(chef_run.node['tags']).to eq(['mysql', 'slave'])
  end
end
