# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_type, :string
  end
end
