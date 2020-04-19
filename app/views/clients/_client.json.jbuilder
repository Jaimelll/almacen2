json.extract! client, :id, :ruc, :razon, :direccion, :origen, :obs, :created_at, :updated_at
json.url client_url(client, format: :json)