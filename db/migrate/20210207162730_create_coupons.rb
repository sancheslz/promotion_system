class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :code, :code, unique: true
      t.references :promotion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
