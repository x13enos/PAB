class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order('created_at DESC').page(params[:page])
  end
end
