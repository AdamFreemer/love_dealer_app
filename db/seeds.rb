Service.find_or_create_by!(name: "Personal Matchmaking") do |s|
  s.notes = "One-on-one introductions, curated by a human who knows your community."
end

Service.find_or_create_by!(name: "Dating Coaching") do |s|
  s.notes = "One-on-one sessions to refine your approach and show up confidently on dates."
end

Service.find_or_create_by!(name: "Group Video Mixers") do |s|
  s.notes = "Curated virtual gatherings for Jewish singles — small groups, warm energy, low pressure."
end

User.find_or_create_by!(email: "adam@freemer.com") do |u|
  u.first_name = "Adam"
  u.last_name = "Freemer"
  u.password = "password123"
  u.admin = true
  u.status = :accepted
end
