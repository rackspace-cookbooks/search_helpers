# Encoding: utf-8

require_relative 'spec_helper'

describe command('uname') do
  its(:stdout) { should match(/Linux/) }
end

# we don't do much testing here. the chefspec tests exercise the entire
# functionality, and already use a chef-zero (in memory) chef server. We don't
# get anything extra with real servers being spun up (and we aren't modifying
# the servers), so there's not much really worth testing except convergence.
