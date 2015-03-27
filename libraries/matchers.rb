if defined?(ChefSpec)
  ChefSpec.define_matcher(:discovery)

  def search_discovery(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:discovery, :search, resource)
  end

  def add_discovery(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:discovery, :add, resource)
  end

  def remove_discovery(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:discovery, :remove, resource)
  end
end
