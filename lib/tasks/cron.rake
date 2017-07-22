namespace :cron do
  desc 'Set up cron to get latest weather updates'
  task weather: :environment do
    entries = []
    config = YAML.load_file("#{Rails.root}/config/cron_zipcodes.yml")

    config['zipcodes'].each do |item|
      entries.push( "#{item['cron']} /bin/bash -l -c 'ruby #{Rails.root}/SCRIPTS/get_weather_updates.rb #{item['zip']}' >> #{Rails.root}/log/cron.log 2>&1 " )
    end

    File.open("#{Rails.root}/SCRIPTS/weather.cron", "w+") do |f|
      f.puts(entries)
    end

    `crontab "#{Rails.root}/SCRIPTS/weather.cron"`
  end
end
