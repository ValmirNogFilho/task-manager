json.extract! task, :id, :title, :status, :priority, :created_at, :updated_at
json.url task_url(task, format: :json)
