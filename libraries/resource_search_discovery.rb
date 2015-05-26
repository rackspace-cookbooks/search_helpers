require 'poise'

class Chef
  class Resource::Discovery < Resource
    include Poise

    actions(:search, :add, :remove)

    attribute(:tags, kind_of: Array, default: [])
    attribute(:block, kind_of: Proc, default: nil)
  end
end
