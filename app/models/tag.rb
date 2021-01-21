class Tag < ApplicationRecord
    has_many :recipe_tags
    has_many :recipes, :through => :recipe_tags

    validates :name, uniqueness: true

    def self.query_tags(search_term)
        self.select("id, name").where(["name like ?", "%#{search_term}%"])
    end
end
