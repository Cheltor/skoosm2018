class AddPlanToBusiness < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :plan_id, :integer
  end
end
