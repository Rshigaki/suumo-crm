json.extract! interaction, :id, :customer_id, :user_id, :company_id, :started_at, :ended_at, :recording_url, :transcript, :memo, :questionnaire_data, :status, :created_at, :updated_at
json.url interaction_url(interaction, format: :json)
