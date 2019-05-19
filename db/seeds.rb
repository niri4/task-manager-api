user= User.find_by(email: 'admin@track.com')
user = User.create!(name: 'admin', email: 'admin@track.com', password: '1234', password_confirmation: '1234') unless user.present?
user.statuses.create(name: 'New', color: 'primary')
user.statuses.create(name: 'In progress', color: 'success')
user.statuses.create(name: 'Complete', color: 'light')
user.labels.create(name: 'Urgent', color: "primary")
user.labels.create(name: 'home', color: "success")
