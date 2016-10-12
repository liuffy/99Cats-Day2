class AddIndexToCatRentalRequests < ActiveRecord::Migration
  def change
      add_column :cat_rental_requests, :user_id, :integer, index: true, null: false, default: 1
  end
end
