module DoctorAvailability
  module AvailabilityPresenter
    class << self
      def present(doctors)
        doctors.each do |doctor|
          puts "#{doctor.name} is available"
        end
      end
    end
  end
end
