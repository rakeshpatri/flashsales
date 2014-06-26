class Deal < ActiveRecord::Base
	has_many :user_deals, :dependent => :destroy
	has_many :users, :through => :user_deals

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png','image/gif','image/jpg']

  validates :publish_date, presence: true, exclusion: {in: Deal.pluck(:publish_date), message: "already assigned"}
  validates :price, presence: true
  validates :discounted_price, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :image, presence: true
  validate :publish_date_greater_than_or_equal_to_today
  after_create :update_status

  rails_admin do
    edit do
      field :title
      field :description
      field :price
      field :discounted_price
      field :quantity
      field :publish_date
      field :image
    end
    list do
      field :title
      field :description
      field :price
      field :discounted_price
      field :quantity
      field :publish_date
      field :status
      field :image
    end   
  end

  def update_status
    update_attribute(:status,'scheduled')
  end

  def publish_date_greater_than_or_equal_to_today
    if publish_date.present? && publish_date < Date.today
      errors.add(:publish_date, 'should be greater than or equal to Today..')
    end
    
  end
  
  def self.publish
  	deal = Deal.where(publish_date: Date.today)
  	deal.update_attribute(:status, "Published") if deal.present?
  end

  def self.expire
    old_deal = Deal.where(status: "published")
    old_deal.update_attribute(:status, "expired") if old_deal.present?
  end
end
