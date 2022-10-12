json.extract! battle, :id, :initiator_id, :opponent_id, :status, :winner_id, :created_at, :updated_at
json.url battle_url(battle, format: :json)
