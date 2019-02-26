module DoctorAvailability
  class Doctor
    attr_reader :name

    def initialize(name:, **days_available)
      @name           = name
      @days_available = days_available.with_indifferent_access
    end

    def available_on?(weekday_name)
      raise(NoSuchDayError, weekday_name) unless WEEKDAYS.include?(weekday_name)

      @days_available[weekday_name]
    end
  end
end
