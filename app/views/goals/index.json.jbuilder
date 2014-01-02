json.array!(@goals) do |goal|
  json.extract! goal, :id, :name, :token, :current_streak, :record_streak
  json.url goal_url(goal, format: :json)
end
