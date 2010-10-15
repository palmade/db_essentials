require 'rubygems'
gem 'echoe'
require 'echoe'

Echoe.new("db_essentials") do |p|
  p.author = "palmade"
  p.project = "palmade"
  p.summary = "Database essential extentions"

  p.dependencies = [ ]

  p.need_tar_gz = false
  p.need_tgz = true

  p.clean_pattern += [ "pkg", "lib/*.bundle", "*.gem", ".config" ]
  p.rdoc_pattern = [ 'README', 'LICENSE', 'COPYING', 'lib/**/*.rb', 'doc/**/*.rdoc' ]
end

gem 'rspec'
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
  t.spec_opts.push("-f s")
end

task :default => [ :spec ]
task :test => [ :spec ]

task :test_prepare do
  FileUtils.mkpath('config')
  FileUtils.mkpath('log')
  FileUtils.touch('log/development.log')
  FileUtils.touch('log/test.log')

  CONFIG_DATABASE_YML_TEMPLATE = <<CDYT
development: &dev
  username: root
  password:
  host: 127.0.0.1
  port: 3306
  database: db_essentials_development
  encoding: utf8
  pool: 5
  adapter: mysql

test: &test
  database: db_essentials_test
  <<: *dev
CDYT

  File.open('config/database.yml', 'w') do |f|
    f.write(CONFIG_DATABASE_YML_TEMPLATE)
  end
end
