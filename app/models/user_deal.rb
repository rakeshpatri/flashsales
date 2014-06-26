class UserDeal < ActiveRecord::Base
	belongs_to :user,:inverse_of => :user_deals
	belongs_to :deal,:inverse_of => :user_deals

	validates :user_id, uniqueness: {scope: :deal_id, message: " Deal can be availed once only."}
end
