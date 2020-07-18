require 'rails_helper'

RSpec.describe User, type: :model do

  
  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名前、パスワードがあれば有効な状態であること
  # it "is valid with name, email, and password" do
  #   user = User.new(
  #     name: "sample",
  #     email: "example@example.com",
  #     password: "password",
  #   )
  #   expect(user).to be_valid
  # end

  
  it "ユーザー名がなければ無効な状態であること" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end


  it "ユーザー名が80文字より多ければ無効" do
    user = FactoryBot.build(:user, name: "a"*81)
    user.valid?
    expect(user.errors[:name]).to include('is too long (maximum is 80 characters)')
  end

   
  it "メールアドレスがなければ無効な状態であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  
  it "重複したメールアドレスがならば無効な状態であること" do

    FactoryBot.create(:user, email: "tester@example.com")
    user = FactoryBot.build(:user, email: "tester@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")

  end
 
  it "パスワードがなければ無効な状態であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "パスワードが5文字以下ならば無効な状態であること" do
    user = FactoryBot.build(:user, password: "a"*5)
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end



end
