class AddApprovedToPromotion < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :approved, :boolean, :default => false
  end
end
