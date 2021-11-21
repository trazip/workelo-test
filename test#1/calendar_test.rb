require 'rspec/autorun'
require_relative './calendar.rb'

describe Calendar do
  let(:calendar) { Calendar.new }
  let(:andy_file) { "./datasets/input_andy.json" }
  let(:sandra_file) { "./datasets/input_sandra.json" }

  describe '#availabilities' do
    describe 'skeleton' do
      it 'should return a hash' do
        expect(calendar.availabilities(60)).to be_a Hash
      end

      it 'should return a date as a key' do
        expect(calendar.availabilities(60, andy_file, sandra_file).keys.first).to eq('2022-08-01')
      end

      it 'should return an array of ranges as a value' do
        expect(calendar.availabilities(60, andy_file, sandra_file).values.first).to be_a Array
        expect(calendar.availabilities(60, andy_file, sandra_file).values.first.first).to be_a Range
      end
    end

    describe 'behaviour' do
      it 'should return a timeslot when there is one' do
        expect(calendar.availabilities(60, andy_file, sandra_file)['2022-08-01']).to eq(["14:00".."15:00"])
      end

      it 'should return an empty array when no open times were found' do
        expect(calendar.availabilities(60, andy_file, sandra_file)['2022-08-03']).to match([])
      end

      it 'should several timeslots when there are some' do 
        expect(calendar.availabilities(60, andy_file, sandra_file)['2022-08-04']).to eq(
          ["15:00".."16:00", "17:00".."18:00"]
        )
      end

      it 'should work with meeting time of 30 minutes' do
        expect(calendar.availabilities(30, andy_file, sandra_file)['2022-08-01']).to eq(
          ["14:00".."14:30", "14:30".."15:00"]
        )
      end

      it 'should work with different working hours' do
        evening_hours = Calendar.new(starts_at: Time.parse('15:00 +0200'), ends_at: Time.parse('20:00 +0200'))
        expect(evening_hours.availabilities(60, andy_file, sandra_file)['2022-08-03']).to eq(
          ["18:00".."19:00", "19:00".."20:00"]
        )
      end
    end
  end
end