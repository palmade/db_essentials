require 'rubygems'

unless defined?(STACK_APP_ROOT)
  STACK_APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
end

if ENV.include?('popo_path')
  POPO_PATH = ENV['popo_path']
  POPO_TARGET = ENV['popo_target']

  require File.join(ENV['popo_path'], 'frameworks/palmade_extensions/lib/palmade_extensions')
else
  require File.join(root_path, '../palmade_extensions/lib/palmade_extensions')
end

RAILS_ENV = 'test'

# boot Rails
Palmade.require_gem('stack', 'palmade/stack')
Palmade::Stack::Initializer.boot_environment(STACK_APP_ROOT)
Palmade::Stack.init(:stack => :rails_adhoc) do |initializer, stack_config|
  stack_config.rails.gem_version = "2.3.8"

  stack_config.rails.post_boot = lambda do
    require File.expand_path(File.join(File.dirname(__FILE__), '../lib/palmade/db_essentials'))
  end

  stack_config.rails.pre_init = lambda do |rails_config, railsi|
    railsi.instance_variable_set(:@environment_loaded, true)

    rails_config.frameworks += [ :active_record ]
    rails_config.time_zone = 'UTC'
  end
end
