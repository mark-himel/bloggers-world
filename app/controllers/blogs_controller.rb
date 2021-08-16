class BlogsController < ApplicationController
  def index
    @blogs = BlogManager.get_list
  end

  def show
    @blog = BlogManager.get_blog(params[:id])
    @comments = BlogManager.get_comments(params[:id])
  end

  def new
  end

  def create
    @blog = BlogManager.post_blog(blog_params)
    if @blog['errors'].nil?
      redirect_to blog_path(id: @blog['post']['id']), notice: 'Blog successfully created!'
    else
      redirect_to root_path, alert: 'Blog was failed to create!'
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :body)
  end
end
