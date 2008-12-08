class NewsletterSubscriptionsController < ApplicationController
  protect_from_forgery :except => :create
  make_resourceful do
    actions :create
    response_for :create do
      flash[:notice] = "Thanks for signing up!"
      redirect_to root_path
    end
  end
end
