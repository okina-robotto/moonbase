class Init < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
      CREATE EXTENSION IF NOT EXISTS "btree_gist";
    SQL
  end
end
