require 'doctor_availability/version'
require 'active_support/all'
require 'csv'
require 'doctor_availability/weekdays'
require 'doctor_availability/doctor'
require 'doctor_availability/csv_parser'
require 'doctor_availability/doctor_finder'
require 'doctor_availability/availability_presenter'

module DoctorAvailability
  class Error < StandardError; end

  class << self
    def find_doctor(weekday)
      AvailabilityPresenter.present(DoctorFinder.find_for(weekday))
    end
  end
end
