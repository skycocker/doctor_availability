module DoctorAvailability
  class Doctor
    attr_reader :name

    def initialize(name:, **days_available)
      @name           = name
      @days_available = days_available.with_indifferent_access
    end

    def available_on?(weekday_name)
      @days_available[weekday_name]
    end
  end
end
