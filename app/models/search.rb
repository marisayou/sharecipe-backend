class Search < ApplicationRecord

    def self.query_searches(search_term, resource_type)
        self.find_by_sql(["SELECT * FROM searches WHERE search_term LIKE ? AND resource_type = ?;", "%#{search_term}%", resource_type])
    end

end
