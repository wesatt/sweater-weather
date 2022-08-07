# frozen_string_literal: true

class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :token
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
