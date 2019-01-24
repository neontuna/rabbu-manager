json.extract! listing, :id, :title, :address, :user_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
