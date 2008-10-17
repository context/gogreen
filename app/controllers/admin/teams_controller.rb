class Admin::TeamsController < AdminController
  make_resourceful do
    actions :all
  end
end
