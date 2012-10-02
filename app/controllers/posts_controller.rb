class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to '/posts', notice: "You don't have access to edit this post!"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
#        flash[:success] = "Post created!"
#        redirect_to @post
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #Not allowing the other user to delete a post...!! but still it can be updated...!!
  def correct_user
    @post = current_user.posts.find_by_id(params[:id])
    if @post.nil?
      redirect_to '/posts', notice: 'Sorry you cannot delete this post!'
    else
      redirect_to '/posts', notice: 'The post has been deleted!'
    end
  end
  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
