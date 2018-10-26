class AddKarmaToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :karma, :integer, :default => 0
  end
end
