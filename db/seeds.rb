require 'csv'

unless AdminUser.any?
  email    = 'admin@example.com'
  password = 'password'
  AdminUser.create!(email: email, password: password, password_confirmation: password)
  puts "Created an admin user with email: #{email} and password: #{password}"
end

data_path      = Rails.root.join('db/data')
states         = data_path.join('ekatte-bulgarian-states.csv')
municipalities = data_path.join('ekatte-bulgarian-municipalities.csv')
towns          = data_path.join('ekatte-bulgarian-towns.csv')

CSV.foreach(states, headers: true).each do |row|
  record = State.find_by_code(row['oblast'])

  if record
    puts "State exists: #{row['name']}"
  else
    State.create! code: row['oblast'], name: row['name']
    puts "State created: #{row['name']}"
  end
end

CSV.foreach(municipalities, headers: true).each do |row|
  record = Municipality.find_by_code(row['obstina'])

  if record
    puts "Municipality exists: #{row['name']}"
  else
    state_code = row['obstina'][0..2]
    state = State.find_by_code(state_code)
    if state
      Municipality.create! code: row['obstina'], name: row['name'], state_id: state.id
      puts "Municipality created: #{row['name']} (in #{state.name})"
    else
      puts "ERROR creating municipality #{row['name']} - uknown state #{state_code} (#{row.inspect}"
      exit 1
    end
  end
end

CSV.foreach(towns, headers: true).each do |row|
  town_code         = row['ekatte']
  state_code        = row['oblast']
  municipality_code = row['obstina']

  record = Town.find_by_code town_code

  if record
    puts "Town exists: #{row['name']}"
  else
    municipality = Municipality.find_by_code municipality_code
    if municipality
      state = State.find_by_code state_code
      if municipality.state != state
        puts "ERROR: Mismatch in state for #{row['name']}. We think it should be #{municipality.state.name}, but it is #{state.try(:name)}. Row: #{row.inspect}"
        exit 2
      end

      Town.create! kind: row['t_v_m'], code: town_code, name: row['name'], municipality_id: municipality.id
      puts "Town created: #{row['name']} (in #{municipality.name}, #{state.name})"
    else
      puts "ERROR creating town #{row['name']} - uknown municipality #{municipality_code} (#{row.inspect}"
      exit 3
    end
  end
end
