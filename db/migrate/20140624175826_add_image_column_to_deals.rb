class AddImageColumnToDeals < ActiveRecord::Migration
  def change
  	add_attachment :deals, :image
  end
end
