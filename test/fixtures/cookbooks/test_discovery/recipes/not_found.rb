discovery 'please dont exist' do
  tags ['florida', 'gainesville']
  block do |node|
    node.run_state['test-kitchen-search-helpers-shouldntexist'] = true
  end
  action :search
end
