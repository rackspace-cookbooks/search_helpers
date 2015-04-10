require_relative 'spec_helper'

describe 'test_discovery::not_found' do
  let(:chef_run) { ChefSpec::ServerRunner.new(step_into: ['discovery']).converge(described_recipe) }

  it 'should not find anything' do
    expect(chef_run).to search_discovery('please dont exist')
    expect(chef_run.node.run_state['discovery_please dont exist']).to be_empty # not falsey or nil, empty!
  end
end
