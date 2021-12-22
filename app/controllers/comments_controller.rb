class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: :destroy

  # POST /comments or /comments.json
  def create
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        CommentsMailer.submitted(@comment).deliver_later
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
