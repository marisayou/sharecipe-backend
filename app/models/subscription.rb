class Subscription < ApplicationRecord
  belongs_to :subscribed_from, :class_name => 'User'
  belongs_to :subscribed_to, :class_name => 'User'
end
