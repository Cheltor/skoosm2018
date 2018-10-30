class AddUniversityToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :university_id, :integer
  end
end
