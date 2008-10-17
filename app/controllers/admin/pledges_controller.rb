class Admin::PledgesController < AdminController
  make_resourceful do
    actions :index
  end
end
