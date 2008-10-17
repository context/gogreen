class Admin::UsersController < AdminController
  make_resourceful do
    actions :update
    before :update do
      @user.disabled = params[:user][:disabled]
      flash[:notice] = "User #{@user.disabled? ? 'disabled' : 'enabled'}" if @user.disabled_changed?
      @user.receive_email = params[:user][:receive_email]
      flash[:notice] = "User #{@user.receive_email? ? 'will' : 'will not'} receive email" if @user.receive_email_changed?
    end
    response_for :update do
      redirect_to admin_pledges_path
    end
  end
end
