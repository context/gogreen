class Admin::PledgesController < ApplicationController
  make_resourceful do
    actions :index
  end
end
