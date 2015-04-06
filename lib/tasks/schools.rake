namespace :app do
  namespace :schools do
    desc 'Import a list of schools from a CSV file found in the SCHOOLS env variable.'
    task import: :environment do
      require 'csv'
      require 'net/http'
      require 'uri'

      csv_path = ENV['SCHOOLS']
      if csv_path.blank?
        STDERR.puts 'Please set the SCHOOLS env variable to a path or URL to a CSV file with schools.'
        exit 1
      end

      csv_data =
        if File.exist?(csv_path)
          File.read(csv_path)
        else
          Net::HTTP.get(URI.parse(csv_path)).force_encoding('UTF-8')
        end

      predefined_disciplines         = Options.for('disciplines')
      predefined_available_equipment = Options.for('available_equipment')
      predefined_meetup_options      = Options.for('meetup_options')

      CSV.parse(csv_data, headers: true) do |row|
        state_name = row['state'].strip
        state = State.find_by_name(state_name)
        if state.nil?
          STDERR.puts "Unknown state: #{state_name} for #{row.inspect}"
          exit 2
        end

        town_name = row['town'].sub(/(гр|с)\.\s*/, '').strip

        town = Town.joins(:municipality).where(municipalities: {state_id: state.id}, name: town_name).first
        if town.nil?
          STDERR.puts "Unknow town: #{town_name} for #{row.inspect}"
          exit 3
        end

        school   = School.where(name: row['name'], town_id: town.id).first
        school ||= School.new name: row['name'], town_id: town.id

        # Main attributes
        school.attributes = row.to_h.slice('address', 'contact_name', 'email', 'phone', 'visit_dates', 'remarks')

        # Login attributes
        school.password = school.password_confirmation = SecureRandom.hex
        school.skip_confirmation!
        school.confirmed_participation = true

        # Disciplines
        disciplines           = row['disciplines'].to_s.split(/\s*,\s*/)
        school.disciplines    = disciplines.map { |discipline| predefined_disciplines.key(discipline) }.compact
        remaining_disciplines = disciplines.reject { |discipline| predefined_disciplines.value?(discipline) }
        school.disciplines    = ['other'] if school.disciplines.blank?

        if remaining_disciplines.any?
          school.remarks ||= ''
          school.remarks += "\n\nПредмети: #{remaining_disciplines.join(', ')}"
        end

        # Available_equipment
        available_equipment        = row['available_equipment'].to_s.split(/\s*,\s*/)
        school.available_equipment = available_equipment.map { |equipment| predefined_available_equipment.key(equipment) }.compact
        remaining_options          = available_equipment.reject { |equipment| predefined_available_equipment.value?(equipment) }
        school.available_equipment = ['other'] if school.available_equipment.blank?

        if remaining_options.any?
          school.remarks ||= ''
          school.remarks += "\n\nНалична техника: #{remaining_options.join(', ')}"
        end

        # Meetup_options
        meetup_options        = row['meetup_options'].to_s.split(/\s*,\s*/)
        school.meetup_options = meetup_options.find { |option| predefined_meetup_options.key(option) }
        remaining_options     = meetup_options.reject { |option| predefined_meetup_options.value?(option) }
        school.meetup_options = 'other' if school.meetup_options.blank?

        if remaining_options.any?
          school.remarks ||= ''
          school.remarks += "\n\nВъзможност за организация на еднократната сбирка в извънучебно време: #{remaining_options.join(', ')}"
        end

        school.remarks = school.remarks.strip if school.remarks

        new_record = school.new_record?

        if school.save
          school_info = "#{school.name} (#{school.town.full_name})"

          if new_record
            puts "NEW school: #{school_info} (password: #{school.password})"
          else
            puts "Existing school: #{school_info}"
          end
        else
          STDERR.puts "ERROR: #{school.errors.full_messages.to_sentence} for #{row.inspect}"
          exit 4
        end
      end
    end
  end
end