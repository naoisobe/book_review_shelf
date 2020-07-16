class PostsController < ApplicationController
  before_action :logged_in_user, ecxept: :index
  before_action :correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @posts = Post.all.order(created_at: :desc)
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def new
    @post = Post.new
    @current_user = User.find_by(id: session[:user_id])
    if @current_user == nil
      flash[:danger] = "ログインが必要です"
      redirect_to login_url
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿が完了しました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:success] = "投稿を編集しました"
      redirect_to "/users/#{@post.user_id}"
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to "/users/#{@post.user_id}"
  end

  

  private

    def post_params
      params.require(:post).permit(:title, :summary, :review, :note, :user_id, :isbn_code)
    end

    def correct_user
      @post = Post.find_by(id: params[:id])
      if @post.user_id != @current_user.id
        flash[:danger] = "権限がありません"
        redirect_to posts_path
      end
    end

end
