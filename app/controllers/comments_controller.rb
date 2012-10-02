class CommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
#  before_filter :correct_user,   only: :destroy

#  def create


  #  @post = Post.find(params[:post_id])
  #  @comment = @post.comments.create(params[:comment])
  #  @comment.user.id = current_user.id
  #  redirect_to post_path(@post)
  #end

  def destroy
  	@post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
#end


  def edit
    @post=Post.find(params[:post_id])
    @comments=Comment.all
    @comment = Comment.find(params[:id])
    render "/posts/show"
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    @comment.commenter = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path @post, notice: 'Comment was successfully saved.' }
        format.json { head :no_content }
      else
        format.html { render "posts/show" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post=Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "posts/show" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

end

