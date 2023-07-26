class CreateApiTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :api_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token, index: { unique: true }
      t.string :description

      t.timestamps
    end
  end
end
