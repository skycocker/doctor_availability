RSpec.describe DoctorAvailability do
  it 'has a version number' do
    expect(DoctorAvailability::VERSION).not_to be nil
  end

  describe '.find_doctor' do
    subject { described_class.find_doctor(argument) }

    context 'on sample data' do
      describe 'requested for Monday' do
        let(:argument) { 'Monday' }

        it 'returns Dr. Kim and Dr. May' do
          expect(STDOUT).to receive(:puts).with('Dr. Kim is available')
          expect(STDOUT).to receive(:puts).with('Dr. May is available')

          subject
        end
      end

      describe 'requested for Tuesday' do
        let(:argument) { 'Tuesday' }

        it 'returns Dr. Adamski and Dr. May' do
          expect(STDOUT).to receive(:puts).with('Dr. Adamski is available')
          expect(STDOUT).to receive(:puts).with('Dr. May is available')

          subject
        end
      end

      describe 'requested for Wednesday' do
        let(:argument) { 'Wednesday' }

        it 'returns Dr. Kim and Dr. Adamski' do
          expect(STDOUT).to receive(:puts).with('Dr. Kim is available')
          expect(STDOUT).to receive(:puts).with('Dr. Adamski is available')

          subject
        end
      end

      describe 'requested for Thursday' do
        let(:argument) { 'Thursday' }

        it 'returns Dr. Adamski' do
          expect(STDOUT).to receive(:puts).with('Dr. Adamski is available')

          subject
        end
      end

      describe 'requested for Friday' do
        let(:argument) { 'Friday' }

        it 'returns nobody' do
          expect(STDOUT).not_to receive(:puts)

          subject
        end
      end

      describe 'requested for Saturday' do
        let(:argument) { 'Saturday' }

        it 'returns Dr. Kim, Dr. Adamski and Dr. May' do
          expect(STDOUT).to receive(:puts).with('Dr. Kim is available')
          expect(STDOUT).to receive(:puts).with('Dr. Adamski is available')
          expect(STDOUT).to receive(:puts).with('Dr. May is available')

          subject
        end
      end

      describe 'requested for Sunday' do
        let(:argument) { 'Sunday' }

        it 'returns Dr. Kim and Dr. May' do
          expect(STDOUT).to receive(:puts).with('Dr. Kim is available')
          expect(STDOUT).to receive(:puts).with('Dr. May is available')

          subject
        end
      end

      describe 'requested for a non-existent weekday' do
        let(:argument) { 'Funday' }

        it 'returns an error' do
          expect(STDOUT).not_to receive(:puts)
          expect(STDERR).to receive(:puts).with('there is no such day as Funday, check your spelling and try again')

          expect { subject }.to raise_error(
            described_class::NoSuchDayError,
            'Funday',
          )
        end
      end
    end
  end
end
