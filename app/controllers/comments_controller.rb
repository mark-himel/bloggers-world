class CommentsController < ApplicationController
  def create
    BlogManager.post_comment(comment_params[:post_id], comment_params)
    @comments = BlogManager.get_comments(comment_params[:post_id])
    @blog_id = comment_params[:post_id]
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :body, :post_id)
  end
end
