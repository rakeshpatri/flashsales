json.array!(@deals) do |deal|
  json.extract! deal, :id, :index, :show
  json.url deal_url(deal, format: :json)
end
