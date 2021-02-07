class AddStatusToCoupon < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :status, :int
  end
end
