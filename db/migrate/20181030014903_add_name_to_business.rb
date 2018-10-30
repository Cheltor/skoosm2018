class AddNameToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :name, :string
  end
end
