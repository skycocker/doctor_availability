module DoctorAvailability
  class CsvParser
    DEFAULT_FILE_PATH = './doctors.csv'.freeze

    WEEKDAY_VALUES = {
      'ON'  => true,
      'OFF' => false,
    }.freeze

    def self.parse_default_file
      new(DEFAULT_FILE_PATH).to_attributes
    end

    def initialize(file_path)
      input_data    = CSV.parse(File.read(file_path), headers: true)
      @parsed_lines = input_data.map(&Line.method(:new)).select(&:valid?)
    end

    def to_attributes
      @attribute_hash ||= @parsed_lines.map(&:to_attributes)
    end
  end
end
