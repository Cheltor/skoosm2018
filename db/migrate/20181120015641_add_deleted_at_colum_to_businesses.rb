class AddDeletedAtColumToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :deleted_at, :datetime
  end
end
