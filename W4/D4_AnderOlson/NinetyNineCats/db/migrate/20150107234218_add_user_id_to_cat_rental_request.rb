class AddUserIdToCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :requester_id, :integer
  end
end
