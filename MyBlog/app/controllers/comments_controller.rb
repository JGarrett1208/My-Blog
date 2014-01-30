class CommentsController < ApplicationController
  before_action :authenticate, :except => [:index, :show, :create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:commenter, :body))
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        md5_of_password = Digest::MD5.hexdigest(password)
        username == 'admin' && md5_of_password == '5ebe2294ecd0e0f08eab7690d2a6ee69'
      end
    end
end
