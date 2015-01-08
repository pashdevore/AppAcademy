class AddNotNullConstraintToCatRentalRequest < ActiveRecord::Migration
  def change
    change_column :cat_rental_requests, :requester_id, :integer, null: false
  end
end
