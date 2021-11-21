require 'time'
require 'json'

class Calendar

  def initialize(params = {})
    @starts_at = params.fetch(:starts_at, Time.parse('09:00 +0200'))
    @ends_at = params.fetch(:ends_at, Time.parse('18:00 +0200'))
  end

  def availabilities(meeting_duration, *file_paths)
    schedules = generate_schedules(file_paths)
    results = parse_schedules(schedules, meeting_duration)
    final_hash = substract_slots(results, meeting_duration)
  end

  private

  def generate_schedules(file_paths)
    file_paths.map { |file_path| load_json(file_path) }
  end

  def load_json(file_path)
    JSON.parse(File.read(file_path))
  end

  def split_timerange(timerange, duration_in_minutes = 60)
    slots = []
    start_time = timerange.begin
    end_time = timerange.end
    
    while start_time < end_time
      slot_duration = 60 * duration_in_minutes
      slots << (start_time.strftime('%H:%M')..(start_time += slot_duration).strftime('%H:%M'))
    end
    
    slots
  end
  
  def parse_schedules(schedules, meeting_duration)
    results = {}
    
    schedules.each do |schedule|
      schedule.each do |slot|
        day = Time.parse(slot['start']).strftime('%Y-%m-%d')
        timerange = Time.parse(slot['start'])..Time.parse(slot['end'])
        
        if results.has_key?(day)
          results[day] += split_timerange(timerange, meeting_duration)
        else 
          results[day] = split_timerange(timerange, meeting_duration)
        end
      end
    end
    
    results 
  end
  
  def generate_day(meeting_duration)
    split_timerange(@starts_at..@ends_at, meeting_duration)
  end

  def substract_slots(results, meeting_duration)
    results.keys.each { |key| results[key] = generate_day(meeting_duration) - results[key].uniq }
    return results
  end
end
