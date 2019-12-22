# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[5.0]
  def self.up
    create_table :pages do |t|
      t.string :url, null: false
      t.integer :status, null: false
      t.string :title
      t.timestamps
    end

    add_index :pages, :url, unique: true
  end

  def self.down
    drop_table :pages
  end
end
