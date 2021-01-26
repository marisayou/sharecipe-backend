class SubscriptionsController < ApplicationController

    def create
        subscription = Subscription.find_or_create_by(subscription_params)
        render json: subscription
    end

    def destroy
        subscription = Subscription.find_by(subscription_params)
        subscription.destroy
    end

    private
    def subscription_params
        params.require(:subscription).permit(:subscribed_from_id, :subscribed_to_id)
    end
end
