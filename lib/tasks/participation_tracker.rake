

namespace :participation_tracker do
  def request_api(url)
    response = Excon.get(
      url#,
      # headers: {
      #   'X-RapidAPI-Host' => URI.parse(url).host,
      #   'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      # }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  desc "fetch and handle event list from bmes participation tracker"
  task update_events: :environment do
    events = Event.all
    request_api('https://guarded-plateau-56846.herokuapp.com/api/v1/events')["events"].each do |pt_event|
      event_exists = false
      events.each do |event|
        unless event.participation_tracker_id then
          if event.start_time == pt_event["start_time"] then
            puts "#{event.name} is the same as #{pt_event["name"]} based on the time. The shared id is: #{pt_event["id"]}"
            event.update(participation_tracker_id: pt_event["id"])
          end
        end
        if event.participation_tracker_id == pt_event["id"] then
          event_exists = true
          break
        end
      end
      unless event_exists then
        puts "#{pt_event["name"]} does not exist, so it is getting created. The shared id is: #{pt_event["id"]}"
        Event.create(name: pt_event["name"], start_time: pt_event["start_time"], participation_tracker_id: pt_event["id"], event_type: 'general', hidden: false)
      end
    end
  end
end
