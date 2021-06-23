class PostsController < ApplicationController
  def show
    @post = Post.published.find_by_permalink(params[:permalink])
    raise NotFound unless @post
    respond_to do |wants|
      wants.html
      wants.mobile do
        @previous_post = Post.published.before(@post).first(:include => :comments)
        @next_post = Post.published.after(@post).first(:include => :comments)
      end
    end
  end
  
  def index
    respond_to do |wants|
      wants.html do
        @posts = Post.published.find_all_for_archive
      end
      wants.mobile do
        @posts = Post.published.all(:include => :comments)
        @posts_by_year_month = @posts.group_by {|p| [p.published_at.year, p.published_at.month]}
      end
      wants.atom do
        @posts = Post.published.find_all_for_archive
      end
    end
  end
  
  def index_by_year
    @posts = Post.published.find_all_for_archive_by_year(params[:year].to_i)
    raise NotFound if @posts.empty?
    render :template => 'posts/index'
  end
  
  def legacy
    post = Post.find_legacy(params[:permalink])
    redirect_to post_url(:year => post.published_at.year, :permalink => post.permalink), 
                :status => 301
  end
end
