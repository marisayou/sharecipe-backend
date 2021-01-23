class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :search_term
      t.string :resource_type
      t.bigint :resource_id

      t.timestamps
    end
  end
end
