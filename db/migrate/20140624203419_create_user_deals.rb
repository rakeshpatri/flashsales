class CreateUserDeals < ActiveRecord::Migration
  def change
    create_table :user_deals do |t|
    	t.integer :user_id
    	t.integer :deal_id
    	t.float :deal_amount
      t.timestamps
    end
  end
end
