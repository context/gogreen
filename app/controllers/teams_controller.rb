class TeamsController < ApplicationController
  make_resourceful do
    actions :show, :index
  end
end
