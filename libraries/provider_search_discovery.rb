require 'poise'

class Chef
  class Provider::Discovery < Provider
    include Poise

    def action_search
      converge_by("search #{new_resource.name}") do
        notifying_block do
          # initial setup & validation
          sanity_checks

          # figure out query and returned key
          query = new_resource.tags.map { |t| "tags:#{t}" }.join(' AND ')
          run_state = "discovery_#{new_resource.name}"
          node.run_state[run_state] = []

          # run the actual search and process results
          Chef::Search::Query.new.search(:node, query) do |i|
            # we must filter to avoid nested tags that come back from search but aren't at the top level
            next unless i['tags'] # skip results that have no tags

            # set skip to true if a required tag is missing for this node
            skip = false
            new_resource.tags.each do |t|
              skip = true unless i['tags'].include?(t)
            end
            next if skip

            # temporarily hold onto i
            obj = i
            if new_resource.block
              ret = new_resource.block.call(i)

              # if the block returns something interesting, use it!
              obj = ret if ret
            end
            node.run_state[run_state] << obj
          end
        end
      end
    end

    def action_add
      converge_by("add #{new_resource.name}") do
        notifying_block do
          sanity_checks
          new_resource.tags.each do |t|
            node.tag(t)
          end
        end
      end
    end

    def action_remove
      converge_by("remove #{new_resource.name}") do
        notifying_block do
          sanity_checks
          new_resource.tags.each do |t|
            node.normal[:tags].delete(t)
          end
        end
      end
    end

    private

    def sanity_checks
      return unless Chef::Config[:solo]
      fail 'Cannot use search_discovery with chef_solo, please guard in your recipe'
    end
  end
end
