namespace :app do
  namespace :speakers do
    desc 'Sends an email to all confirmed speakers with no events to create one.'
    task send_reminder_to_create_events: :environment do
      stale_speakers = Speaker.confirmed.no_events

      puts "Sending notification to #{stale_speakers.size} stale speaker(s)..."
      stale_speakers.each do |speaker|
        puts "Emailing #{speaker.email_with_name}..."
        ApplicationMailer.create_an_event(speaker).deliver
      end
    end
  end
end
