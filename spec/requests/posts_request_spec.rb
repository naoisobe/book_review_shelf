require 'rails_helper'

RSpec.describe "Posts", type: :request do


  describe "#show" do
    context "未ログインユーザーの場合" do

      before do 
        @user = FactoryBot.create(:user)
        @post = FactoryBot.create(:post)
      end

      it "302レスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        get post_path(@post), params: { id: @post.id, post: post_params}
        expect(response).to have_http_status "302"
      end

      it "ログイン画面へリダイレクト" do
        post_params = FactoryBot.attributes_for(:post)
        get post_path(@post), params: { id: @post.id, post: post_params}
        expect(response).to redirect_to login_path
      end

    end
  end

  describe "#create" do
    context "ログインユーザーの場合" do

      before do 
        @user = FactoryBot.create(:user)
        post login_path, params: { session: { email: @user.email,
          password: @user.password } }
      end 

      it "新しいpostを作成できる" do
        post_params = FactoryBot.attributes_for(:post)
        post posts_path, params: {post: post_params}
        expect(response).to redirect_to root_path
      end

    end

    context "未ログインユーザーの場合" do

      before do
        post_params = FactoryBot.attributes_for(:post)
        post posts_path, params: { post: post_params }
      end

      it "302レスポンスを返すこと" do
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクト" do
        expect(response).to redirect_to login_path
      end

    end
  end

  describe "#update" do
    context "ログインユーザーの場合" do

      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user, name: "hoge")
        @post = FactoryBot.create(:post, user: @user)
        @other_post = FactoryBot.create(:post, user: other_user)
        post login_path, params: { session: { email: @user.email,
          password: @user.password } }
      end

      it "他人のpostは編集できない" do
        post_params = FactoryBot.attributes_for(:post)
        patch post_path(@other_post), params: { post: post_params}
        expect(response).to redirect_to root_path
      end

      it "自分のpostは編集できる" do
        post_params = FactoryBot.attributes_for(:post, title: "おおおお")
        patch post_path(@post), params: { post: post_params}
        expect(response).to redirect_to user_path(@user)
      end

    end

    context "未ログインユーザーの場合" do

      before do
        @post = FactoryBot.create(:post)
        post_params = FactoryBot.attributes_for(:post)
        patch post_path(@post), params: { post: post_params}
      end

      it "302レスポンスを返すこと" do
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクト" do
        expect(response).to redirect_to login_path
      end
    end
  end
  
  describe "#destroy" do

    context "未ログインユーザーの場合" do

      before do
        @post = FactoryBot.create(:post)
        post_params = FactoryBot.attributes_for(:post)
        delete post_path(@post), params: { post: post_params}
      end

      it "302レスポンスを返すこと" do
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクト" do
        expect(response).to redirect_to login_path
      end
    end
  end
  # destroyアクション：ログイン済みのユーザーでも、他人のpostは削除できない、未ログインのユーザーならばログインページにリダイレクト


  
end
