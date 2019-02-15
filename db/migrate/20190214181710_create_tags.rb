# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :tag_type
      t.string :text
      t.integer :member_id
      t.timestamps
    end
  end
end
