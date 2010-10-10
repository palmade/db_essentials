# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{db_essentials}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["palmade"]
  s.date = %q{2010-10-10}
  s.description = %q{Database essential extentions}
  s.email = %q{}
  s.extra_rdoc_files = ["lib/palmade/db_essentials.rb", "lib/palmade/db_essentials/acts.rb", "lib/palmade/db_essentials/acts/finders.rb", "lib/palmade/db_essentials/acts/misc.rb", "lib/palmade/db_essentials/acts/observer_extensions.rb", "lib/palmade/db_essentials/acts/post_callback.rb", "lib/palmade/db_essentials/acts/sortable.rb", "lib/palmade/db_essentials/acts/table_name.rb", "lib/palmade/db_essentials/connection_pool.rb", "lib/palmade/db_essentials/db_connection.rb", "lib/palmade/db_essentials/db_connection_manager.rb", "lib/palmade/db_essentials/find_extensions.rb", "lib/palmade/db_essentials/helpers.rb", "lib/palmade/db_essentials/helpers/active_record2_helper.rb", "lib/palmade/extend/active_record2/connection_adapters/abstract/connection_pool.rb", "lib/palmade/extend/active_record2/connection_adapters/abstract/connection_specification.rb", "lib/palmade/extend/active_record2/extend.rb"]
  s.files = ["CHANGELOG", "Rakefile", "lib/palmade/db_essentials.rb", "lib/palmade/db_essentials/NOTES", "lib/palmade/db_essentials/acts.rb", "lib/palmade/db_essentials/acts/finders.rb", "lib/palmade/db_essentials/acts/misc.rb", "lib/palmade/db_essentials/acts/observer_extensions.rb", "lib/palmade/db_essentials/acts/post_callback.rb", "lib/palmade/db_essentials/acts/sortable.rb", "lib/palmade/db_essentials/acts/table_name.rb", "lib/palmade/db_essentials/connection_pool.rb", "lib/palmade/db_essentials/db_connection.rb", "lib/palmade/db_essentials/db_connection_manager.rb", "lib/palmade/db_essentials/find_extensions.rb", "lib/palmade/db_essentials/helpers.rb", "lib/palmade/db_essentials/helpers/active_record2_helper.rb", "lib/palmade/extend/active_record2/connection_adapters/abstract/connection_pool.rb", "lib/palmade/extend/active_record2/connection_adapters/abstract/connection_specification.rb", "lib/palmade/extend/active_record2/extend.rb", "Manifest", "db_essentials.gemspec"]
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Db_essentials"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{palmade}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Database essential extentions}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
