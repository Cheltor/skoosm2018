class AddSocialToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :website, :string
    add_column :businesses, :facebook, :string
    add_column :businesses, :twitter, :string
  end
end
