class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy blog_from_url ]

  def index
    @blogs = current_user.blogs
  end

  def show
    @users = User.all
    unless @blog.id == current_user.id
      redirect_to blogs_path
      flash[:notice] = 'You are not authorize to view the requested post'
    end
  end

  def new
    @blog = Blog.new
  end

  def edit; end

  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def blog_from_url; end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :description, :image, :user_id)
    end 
end
