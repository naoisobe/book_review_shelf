class AddIsbnCodeToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :isbn_code, :string
  end
end
