# frozen_string_literal: true

require 'active_record'

namespace :db do
  db_config = {
    'adapter' => 'postgresql',
    'database' => ENV.fetch('DB_NAME') { 'sample_db' },
    'host' => ENV.fetch('DB_HOST') { 'localhost' },
    'port' => ENV.fetch('DB_PORT') { 5432 },
    'username' => ENV.fetch('DB_USER') { 'admin' },
    'password' => ENV.fetch('DB_PASSWORD') { '' }
  }
  db_admin_def = {
    'database' => ENV.fetch('DEFAULT_DB_NAME') { 'sample_db' },
    'schema_search_path' => 'public'
  }
  db_config_admin = db_config.merge(db_admin_def)

  desc 'Create the database'
  task :create do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.create_database(db_config['database'])
    puts 'Database created.'
  end

  desc 'Migrate the database'
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config)
    version = ENV['VERSION'] ? ENV['VERSION'].to_i : nil
    ActiveRecord::Base.connection.migration_context.migrate(version)
    Rake::Task['db:schema'].invoke
    puts 'Database migrated.'
  end

  desc 'Drop the database'
  task :drop do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.drop_database(db_config['database'])
    puts 'Database deleted.'
  end

  desc 'Reset the database'
  task reset: %i[drop create migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config)
    require 'active_record/schema_dumper'
    filename = 'db/schema.rb'
    File.open(filename, 'w:utf-8') do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end
end
