# frozen_string_literal: true

require 'active_record'

# The CreateSamples is Sample
class CreateSamples < ActiveRecord::Migration[6.0]
  # This is Sample
  def self.up
    create_table :samples do |table|
      table.string :body

      table.timestamps
    end
  end

  def self.down
    drop_table :samples
  end
end
