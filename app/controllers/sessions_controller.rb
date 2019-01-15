class SessionsController < ApplicationController
  def new
    render layout: false
    # email = params[:session][:email].downcase
    # password = params[:session][:password]
    # if login(email, password)
    #   flash[:success] = 'ログインに成功しました。'
    # else
    #   flash.now[:danger] = 'ログインに失敗しました。'
    # end  
  end

  def create
    #render layout: false
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to "/"
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      redirect_to "/login"
    end
  end

  def destroy
    
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to "/"
  end
  
  
    private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
