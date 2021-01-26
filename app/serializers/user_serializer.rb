class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :favorites, :subscriptions, :subscriber_count

  def favorites
    self.object.like_recipes.map do |recipe|
      recipe.id
    end
  end

  def subscriptions
    self.object.subscriptions.map do |subscription|
      user = User.find(subscription.subscribed_to_id)
      {id: user.id, name: user.name, username: user.username, recipes_count: user.recipes.count, subscribers_count: user.subscribers.count}
    end
  end

  def subscriber_count
    self.object.subscribers.count
  end

end
