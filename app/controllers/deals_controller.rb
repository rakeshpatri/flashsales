class DealsController < ApplicationController

  before_action :set_deal, only: [:show, :buy]
  before_action :authenticate_user!
  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.where(:status => "published")
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
  end

  def buy
    price = current_user.discounted_price(@deal.discounted_price)
    user_deal = UserDeal.create(user_id: current_user.id, deal_id: @deal.id, deal_amount: price)
    @deal.quantity -= 1 if user_deal.id
    @deal.save!
    redirect_to action: :index
  end

  # GET /deals/new

  # POST /deals
  # POST /deals.json
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:index, :show)
    end
end
