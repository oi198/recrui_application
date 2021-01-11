class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:create, :edit, :update, :destroy]}
  before_action :ensure_correct_post, {only: [:edit, :update, :destroy]}
  before_action :delete_session_post_id

  def index
    @posts_all = Post.all.order(respond: "DESC")
    if @posts_all != [] && session[:post_id] == nil
      session[:post_id] = @posts_all.first.id
    end
    if @posts_all != [] && session[:post_id] != nil
      @posts = @posts_all.where.not(id: session[:post_id])
      @current_post = Post.find_by(id: session[:post_id])
      @chats = Chat.where(post_id: @current_post.id).order(created_at: "DESC")
    end
  end

  def create
    @post = Post.new(user_id: @current_user.id, title: "タイトルなし", respond: 0)
    if @post.save
      session[:post_id] = @post.id
      redirect_to("/")
    else
      render("posts/index")
    end
  end

  def search
    @search_post = Post.find_by(title: params[:title])
    if @search_post != nil
      session[:post_id] = @search_post.id
      redirect_to("/")
    else
      redirect_to("/")
    end
  end

  def change_current_post
    session[:post_id] = params[:post_id]
    redirect_to("/")
  end

  def edit
    @post = Post.find_by(id: params[:post_id])
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    @post.title = params[:title]
    if @post.save
      redirect_to("/")
    else
      @title = params[:title]
      @error_message = "※再度入力して下さい。"
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @chats = Chat.where(post_id: @post.id)
    @chats.destroy_all
    @post.destroy
    session[:post_id] = nil
    redirect_to("/")
  end

  def ensure_correct_post
    if session[:post_id] == nil
      redirect_to("/")
    end
  end

  def delete_session_post_id
    if session[:post_id] != nil
      @post = Post.find_by(id: session[:post_id])
      unless @post
        session[:post_id] = nil
      end
    end
  end
end
