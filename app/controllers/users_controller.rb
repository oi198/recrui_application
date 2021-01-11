class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index]}
  before_action :forbid_login_user, {only: [:signup, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:index, :destroy]}

  def index
    @user = User.find_by(id: params[:user_id])
    @posts = Post.where(user_id: params[:user_id]).order(respond: "DESC")
  end

  def signup
  end

  def login_form
  end

  def create
    @user = User.new(name: params[:name], password: params[:password])
    if params[:password].length > 5 && params[:password].length < 11 && @user.save
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @name = params[:name]
      @password = params[:password]
      @error_message = "※再度入力して下さい。"
      render("users/signup")
    end
  end

  def login
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @name = params[:name]
      @password = params[:password]
      @error_message = "※再度入力して下さい。"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/")
  end

  def edit
    @user = User.find_by(id: params[:user_id])
  end

  def img_update
    @user = User.find_by(id: params[:user_id])
    @user.image = params[:image]
    if @user.save
      redirect_to("/users/#{params[:user_id]}")
    else
      redirect_to("/users/#{params[:user_id]}")
    end
  end

  def name_update
    @user = User.find_by(id: params[:user_id])
    if @user && @user.authenticate(params[:password])
      @user.name = params[:name]
      if @user.save
        redirect_to("/users/#{@user.id}")
      else
        @error_message = "※再度入力して下さい。"
        @name = params[:name]
        @password = params[:password]
        render("users/edit")
      end
    else
      @error_message = "※再度入力して下さい。"
      @name = params[:name]
      @password = params[:password]
      render("users/edit")
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.image.purge
    @events = Event.where(user_id: @user.id)
    @events.destroy_all
    @ess = E.where(user_id: @user.id)
    @ess.destroy_all
    @user.destroy
    session[:user_id] = nil
    redirect_to("/")
  end

  def chats
    @chats = Chat.where(user_id: params[:user_id])
    @user = User.find_by(id: params[:user_id])
  end

  def companies
    @companies = Company.where(user_id: params[:user_id])
    @user = User.find_by(id: params[:user_id])
  end

  def ensure_correct_user
    if params[:user_id].to_i != @current_user.id
      redirect_to("/")
    end
  end
end
