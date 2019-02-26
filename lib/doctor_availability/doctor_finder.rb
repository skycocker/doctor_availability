module DoctorAvailability
  class DoctorFinder
    def self.find_for(weekday)
      new.available_on(weekday)
    end

    def initialize
      @doctors = CsvParser
                   .parse_default_file
                   .map(&DoctorAvailability::Doctor.method(:new))
    end

    def available_on(weekday)
      @doctors.select { |doctor| doctor.available_on?(weekday) }
    end
  end
end
