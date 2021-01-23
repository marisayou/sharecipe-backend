class SearchSerializer < ActiveModel::Serializer
  attributes :id, :search_term, :resource_type, :resource
end
