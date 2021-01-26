class SubscriptionSerializer < ActiveModel::Serializer
  attributes :subscribed_from, :subscribed_to

  def subscribed_from
    self.object.subscribed_from.id
  end

  def subscribed_to
    user = self.object.subscribed_to
    return {id: user.id, name: user.name, username: user.username, recipes_count: user.recipes.count, subscribers_count: user.subscribers.count}
  end
end
