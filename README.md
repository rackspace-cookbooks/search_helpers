# search_helpers

search_helpers is a chef library cookbook designed to streamline common tasks in
Chef that require search.

## [Changelog](CHANGELOG.md)

See CHANGELOG.md for additional information about changes to this stack over time.

## Supported Platforms

Ubuntu 12.04

CentOS 6.5

## Usage

### search_helpers::default

Does not do anything.

### discovery

Provides a rudimentary discovery mechanism on top of chef search, based on a tag
model. Note that while the default implementation relies on underlying Chef
tags, future implementations might not necessarily do so.

The `discovery` resource and provider provides generic actions for applying tags
to any Chef node, as well as enumerating other Chef nodes with a given tag or
running a provided block on all nodes that have specific tags.

Shared attributes supported by all actions of this resource include `tags` and
`block`. The block attribute, by default, is nil. This means
`node.run_state["discovery_#{new_resource.name}"]` will contain an array
of nodes returned from the search. You may also pass a block to `data` and that
block will be executed for each node returned from the search, in addition to
the `node.run_state` being set.

If you return a value from your block (instead of nil),
`node.run_state["discovery_#{new_resource.name}"]` will be populated with an
array of objects returned from the block.

#### `:search`: Default action, Find a node with a particular array of tags

```
discovery 'my_cookbook_mysql_master' do
  tags ['mysql', 'master']
  action :search
end
found_master = node.run_state['discovery_my_cookbook_mysql_master'].first
if found_master
  Chef::Log.info("Found mysql master #{found_master}")
else
  Chef::Log.info('No mysql master was found')
end  
```

Block example:
```
discovery 'find a mysql master' do
  tags ['master', 'mysql']
  block do |node|
    node_ip = best_ip_for(node)
    Chef::Log.warn("#{node.name} was found as a mysql master at #{node_ip}")
    node_ip
  end
  action :search
end
```

#### `:add`: Put this node into a particular haystack as a given needle

```
discovery 'add mysql master tag' do
  tags ['master', 'mysql']
  action :add
end
```

#### `:remove`: Remove this node from a given haystack as a given needle

```
discovery 'no longer consider this node a mysql master' do
  tags ['mysql', 'master']
  action :remove
end
```

## Contributing

See [CONTRIBUTING](https://github.com/AutomationSupport/search_helpers/blob/master/CONTRIBUTING.md).

## Authors

Author:: Rackspace (devops-chef@rackspace.com)

## License
```
# Copyright 2015, Rackspace Hosting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
```
