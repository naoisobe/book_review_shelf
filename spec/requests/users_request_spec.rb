require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "#index" do

    context "未ログインユーザーの場合" do

      it "302レスポンスを返すこと" do
        get users_path
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクト" do
        get users_path
        expect(response).to redirect_to login_path
      end

    end
  end
  

  describe "#show" do
    context "未ログインユーザーの場合" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "302レスポンスを返すこと" do
        user_params = FactoryBot.attributes_for(:user)
        get user_path(@user), params: { id: @user.id, user: user_params}
        expect(response).to have_http_status "302"
      end

      it "ログイン画面にリダイレクト" do
        user_params = FactoryBot.attributes_for(:user)
        get user_path(@user), params: { id: @user.id, user: user_params}
        expect(response).to redirect_to login_path
      end
    end
  end

# destroyアクション：ログイン済みでも他人のアカウントを削除できない、未ログインならログインページにリダイレクト

  describe "#update" do

    context "ログインユーザーの場合" do

      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user, name: "hoge", email: "hoge@hoge.com")
        post login_path, params: { session: { email: @user.email,
          password: @user.password } }
      end


      it "他人のアカウント情報を更新することができない" do
        user_params = FactoryBot.attributes_for(:user, name: "ChangeName")
        # log_in @user
        patch user_path(@other_user), params: {user: user_params}
        expect(@other_user.reload.name).to eq "hoge"
      end

      it "自分のアカウント情報は更新することができる" do
        user_params = FactoryBot.attributes_for(:user, name: "ChangeName")
        # log_in @user
        patch user_path(@user), params: {user: user_params}
        expect(@user.reload.name).to eq "ChangeName"
      end

      it "ルートページにリダイレクトする" do
        user_params = FactoryBot.attributes_for(:user)
        # log_in @user
        patch user_path(@other_user), params: {user: user_params}
        expect(response).to redirect_to root_path
      end

    end

    context "未ログインユーザーの場合" do

      before do
        @user = FactoryBot.create(:user)
      end

      it "302レスポンスを返すこと" do
        user_params = FactoryBot.attributes_for(:user)
        patch user_path(@user), params: { id: @user.id, user: user_params}
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクト" do
        user_params = FactoryBot.attributes_for(:user)
        patch user_path(@user), params: { id: @user.id, user: user_params}
        expect(response).to redirect_to login_path
      end

    end
  end

  describe "#destroy" do

  end
end
