class CreateRedeems < ActiveRecord::Migration[5.0]
  def change
    create_table :redeems do |t|
      t.references :user, foreign_key: true
      t.references :rewardpurchase, foreign_key: true

      t.timestamps
    end
  end
end
