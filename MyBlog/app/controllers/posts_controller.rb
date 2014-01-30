class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, :except => [:index, :show, :like]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    respond_to do |format|
      format.html {}
      format.atom { render layout: false }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.score = 0 #All posts start with zero likes.

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    @post = Post.find(params[:id])
    @post.score = (@post.score + 1)
    @post.save
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :score)
    end

    # Get user name and password
    #def authenticate
    #  authenticate_or_request_with_http_basic "Enter your username and password." do |name, password|
    #    name == "admin" && password == "secret"
    #  end
    #end

    def authenticate
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        md5_of_password = Digest::MD5.hexdigest(password)
        username == 'admin' && md5_of_password == '5ebe2294ecd0e0f08eab7690d2a6ee69'
      end
    end
end
