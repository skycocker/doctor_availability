module DoctorAvailability
  class CsvParser
    DEFAULT_FILE_PATH = './doctors.csv'.freeze
    DOCTOR_LINE_KEY   = 'Doctor Name'.freeze

    WEEKDAY_VALUES = {
      'ON'  => true,
      'OFF' => false,
    }.freeze

    REQUIRED_LINE_KEYS = (
      [DOCTOR_LINE_KEY] + WEEKDAYS
    ).map(&:downcase).freeze

    def self.parse_default_file
      new(DEFAULT_FILE_PATH).to_attributes
    end

    def initialize(file_path)
      input_data = CSV.parse(File.read(file_path), headers: true)

      @parsed_data = input_data
                       .map(&:to_h)
                       .select(&method(:input_line_valid?))
    end

    def to_attributes
      @attribute_hash ||= @parsed_data.map(&method(:data_to_attributes))
    end

    private

    def input_line_valid?(line)
      line_keys_valid?(line) && line_values_valid?(line)
    end

    def line_keys_valid?(line)
      # ditch invalid records
      # whether that means there are too many
      # or too few
      (line.keys.map(&:downcase) - REQUIRED_LINE_KEYS).blank?
    end

    def line_values_valid?(line)
      return false if line[DOCTOR_LINE_KEY].to_s.blank?

      input_weekday_values = line.except(DOCTOR_LINE_KEY).values

      return false if input_weekday_values.size != WEEKDAYS.size

      (input_weekday_values.uniq - WEEKDAY_VALUES.keys).blank?
    end

    def data_to_attributes(hash)
      { name: hash[DOCTOR_LINE_KEY] }.merge(data_values_to_attributes(hash))
    end

    def data_values_to_attributes(hash)
      hash.except(DOCTOR_LINE_KEY).map do |k, v|
        [k.to_sym, WEEKDAY_VALUES[v]]
      end.to_h
    end
  end
end
