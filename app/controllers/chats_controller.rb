class ChatsController < ApplicationController
  before_action :authenticate_user, {only: [:create, :destroy]}

  def create
    @chat = Chat.new(user_id: @current_user.id, post_id: params[:post_id], content: params[:content])
    if @chat.save
      @post = @chat.post
      if @post.user_id != @chat.user_id
        @post.respond += 1
        @post.save
      end
      redirect_to("/")
    end
  end

  def destroy
    @chat = Chat.find_by(id: params[:chat_id])
    @post = @chat.post
    if @post.user_id != @chat.user_id
      @post.respond -= 1
      @post.save
    end
    @chat.destroy
    redirect_to("/")
  end
end
