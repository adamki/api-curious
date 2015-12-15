class AddBackgroundImageUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :background_url, :string
  end
end
