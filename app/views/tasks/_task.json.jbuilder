json.ignore_nil!
json.extract! task, :id, :deadline
json.name truncate(task.name)
json.description truncate(task.description)
json.user do
  json.name task.user.name
  json.email  task.user.email
end

json.url task_url(task, format: :json)
