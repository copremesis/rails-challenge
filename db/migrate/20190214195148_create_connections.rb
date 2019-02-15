# frozen_string_literal: true

class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.references :member
      t.references :friend
      t.timestamps
    end
    add_foreign_key :connections, :members, column: :friend_id, primary_key: :id
    add_foreign_key :connections, :members, column: :member_id, primary_key: :id
  end
end
