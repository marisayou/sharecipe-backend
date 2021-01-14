class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :serving_size
      t.string :instructions
      t.string :photo

      t.timestamps
    end
  end
end
