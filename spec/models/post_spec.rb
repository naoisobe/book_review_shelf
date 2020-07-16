require 'rails_helper'

RSpec.describe Post, type: :model do

  it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:post)).to be_valid
  end

  it "タイトルがなければ無効な状態であること" do
    post = FactoryBot.build(:post, title: nil )
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "タイトルが100字より多ければ無効な状態であること" do
    post = FactoryBot.build(:post, title: "a"*101)
    post.valid?
    expect(post.errors[:title]).to include("is too long (maximum is 100 characters)")
  end

  it "要約がなければ無効な状態であること" do
    post = FactoryBot.build(:post, summary: nil)
    post.valid?
    expect(post.errors[:summary]).to include("can't be blank")
  end

  it "要約が1000字より多ければ無効な状態であること" do
    post = FactoryBot.build(:post, summary: "a"*1001)
    post.valid?
    expect(post.errors[:summary]).to include("is too long (maximum is 1000 characters)")
  end

  it "感想がなければ無効な状態であること" do
    post = FactoryBot.build(:post, review: nil)
    post.valid?
    expect(post.errors[:review]).to include("can't be blank")
  end

  it "感想が1000字より多ければ無効な状態であること" do
    post = FactoryBot.build(:post, review: "a"*1001)
    post.valid?
    expect(post.errors[:review]).to include("is too long (maximum is 1000 characters)")
  end

  it "メモが1000字より多ければ無効な状態であること" do
    post = FactoryBot.build(:post, note: "a"*1001)
    post.valid?
    expect(post.errors[:note]).to include("is too long (maximum is 1000 characters)")
  end

  
end
