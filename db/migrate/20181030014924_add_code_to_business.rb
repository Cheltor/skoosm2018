class AddCodeToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :code, :string
  end
end
