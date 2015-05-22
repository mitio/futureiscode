namespace :app do
  namespace :speakers do
    desc 'Sends an email to all confirmed speakers with no events to create one.'
    task  : :environment do
      stale_speakers = Speaker.confirmed.no_events

      puts "Sending notification to #{stale_speakers} stale speaker(s)..."
      stale_speakers.each do |speaker|
        ApplicationMailer.create_an_event(speaker).deliver
      end
    end
  end
end
