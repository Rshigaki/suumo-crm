json.extract! project, :id, :name, :status, :contract_date, :delivery_date, :estimated_amount, :customer_id, :user_id, :company_id, :created_at, :updated_at
json.url project_url(project, format: :json)
