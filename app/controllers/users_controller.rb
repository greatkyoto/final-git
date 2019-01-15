class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def new
    @user = User.new
    render layout: false
  end

  def create
    @user = User.new(user_params)

    if @user.save
      #render layout: false
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      redirect_to "/"
    end
  end
  
  def destroy
        user = User.find(params["id"])
        user.destroy
        flash[:success] = 'Userアカウント は正常に削除されました'
        redirect_to "/signup"
  end 
  
  def show
    @user = User.find_by(id: session[:user_id])
  end  


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
