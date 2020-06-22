class StaticPagesController < ApplicationController
  def home
    @posts = Post.all.order(created_at: :desc)
  end

  def about
  end
end