json.extract! detail, :id, :descripcion, :cantidad, :precio, :monto, :item_id, :user_id, :created_at, :updated_at
json.url detail_url(detail, format: :json)