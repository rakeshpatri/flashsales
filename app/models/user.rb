class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_deals, :dependent => :destroy
  has_many :deals, :through => :user_deals
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def discounted_price(price)
  	puts "price#{price}"
		deal_nos = self.deals.length
		if deal_nos == 0
			price
		elsif deal_nos == 1
			price -= price*0.01
		elsif deal_nos == 2
			price -= price*0.02
		elsif deal_nos == 3
			price -= price*0.03
		elsif deal_nos == 4
			price -= price*0.04
		else
			price -= price*0.05	
		end
	end

	def can_buy?
		self.deals.where(status: "published").blank?
	end
end
