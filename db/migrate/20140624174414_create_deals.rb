class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
    	t.string :title
    	t.string :description
    	t.float :price
    	t.float :discounted_price
    	t.integer :quantity
    	t.date :publish_date
      t.string :status

      t.timestamps
    end
  end
end
