require_relative 'spec_helper'

describe 'test_discovery::remove' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['discovery']) do |node, server|
      node.tag('mysql', 'foo')
    end.converge(described_recipe)
  end

  it 'should tag and untag the node as mysql and slave' do
    expect(chef_run).to add_discovery('add and remove')
    expect(chef_run).to remove_discovery('add and remove')
    expect(chef_run.node.tags).to be_empty
  end
end
