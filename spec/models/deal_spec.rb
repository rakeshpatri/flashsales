require 'rails_helper'
require 'rack/test'

RSpec.describe Deal, :type => :model do
  context "validations" do
  	before(:each) do
  		@deal1 = Deal.create(title: "watch-sale", description: "buy 1 get 1", price: 1200, discounted_price: 1000, publish_date: (Date.today + 1), quantity: 10, image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg'))
  		@deal2 = Deal.create(title: "saree-sale", description: "50% discount", price: 1200, discounted_price: 600, publish_date: (Date.today + 2), quantity: 10, image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg')) 
  	end
  	
  	it "should save a deal if has a valid publish date" do
  		deal = Deal.new(title: "watch-sale", description: "buy 1 get 1", price: 1200, discounted_price: 1000, publish_date: Date.today, quantity: 10, image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg'))
  		deal.save
  		expect(Deal.count).to eq(3)
  	end

  	it "should  not save a deal if publish date past to today" do
  		deal = Deal.new(title: "watch-sale", description: "buy 1 get 1", price: 1200, discounted_price: 1000, publish_date: Date.today - 1, quantity: 10, image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg'))
  		deal.save
  		expect(Deal.count).to eq(2)
  	end

  	it "should not save a deal if quantity not specified" do
  		deal = Deal.new(title: "watch-sale", description: "buy 1 get 1", price: 1200, discounted_price: 1000, publish_date: (Date.today + 2), image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/test.jpg", 'image/jpg'))
  		deal.save
  		expect(Deal.count).to eq(2)
  	end

  	after(:each) do
  		Deal.destroy_all
  	end
  end
end
