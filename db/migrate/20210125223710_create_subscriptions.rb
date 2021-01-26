class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :subscribed_from, null: false
      t.references :subscribed_to, null: false

      t.timestamps
    end

    add_foreign_key :subscriptions, :users, column: :subscribed_from_id, primary_key: :id
    add_foreign_key :subscriptions, :users, column: :subscribed_to_id, primary_key: :id
  end
end
