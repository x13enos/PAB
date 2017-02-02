class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  layout "admin"

  private

  def authenticate_admin
    current_user.admin?
  end
end
