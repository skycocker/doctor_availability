module DoctorAvailability
  class NoSuchDayError < StandardError
    def initialize(input_weekday)
      STDERR.puts("there is no such day as #{input_weekday}, check your spelling and try again")
      super(input_weekday)
    end
  end
end
