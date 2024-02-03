require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe "validation" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :end_time }

    it "validates end_time is later than start_time" do
      record = Listing.new start_time: 10.minutes.from_now
      expect(record).not_to allow_value(9.minutes.from_now).for(:end_time)
    end
  end
end
