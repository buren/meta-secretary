class UsersController < ApplicationController
  before_action :require_no_user, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: t('user.created', api_key: @user.meta_access_token)
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: t('user.updated')
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def require_no_user
      redirect_to(root_path, status: 301, alert: t('user.unique_user_notice')) and return if User.any?
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:github_access_token, :github_owner_name, :username, :password)
    end
end
