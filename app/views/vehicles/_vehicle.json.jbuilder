json.extract! vehicle, :id, :name, :colour, :price, :make, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
