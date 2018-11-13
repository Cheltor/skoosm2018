class AddStripeCustomerTokenToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :stripe_customer_token, :string
  end
end
