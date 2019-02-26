module DoctorAvailability
  class CsvParser
    class Line
      DOCTOR_KEY    = 'Doctor Name'.freeze
      REQUIRED_KEYS = (
        [DOCTOR_KEY] + WEEKDAYS
      ).map(&:downcase).freeze

      def initialize(line)
        @line = line.to_h
      end

      def valid?
        keys_valid? && values_valid?
      end

      def to_attributes
        { name: @line[DOCTOR_KEY] }.merge(values_to_attributes)
      end

      private

      def keys_valid?
        # ditch invalid records
        # whether that means there are too many
        # or too few
        (@line.keys.map(&:downcase) - REQUIRED_KEYS).blank?
      end

      def values_valid?
        return false if @line[DOCTOR_KEY].to_s.blank?

        input_weekday_values = @line.except(DOCTOR_KEY).values

        return false if input_weekday_values.size != WEEKDAYS.size

        (input_weekday_values.uniq - WEEKDAY_VALUES.keys).blank?
      end

      def values_to_attributes
        @line.except(DOCTOR_KEY).map do |k, v|
          [k.to_sym, WEEKDAY_VALUES[v]]
        end.to_h
      end
    end
  end
end
