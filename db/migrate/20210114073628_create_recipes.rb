class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :recipe, null: false, default: '{}'

      t.timestamps
    end
  end
end
