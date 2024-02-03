require 'rails_helper'

RSpec.describe XmlParserService, type: :services do
  let(:data)            { File.read('spec/fixtures/data.xml') }
  let(:expected_result) { YAML.load_file('spec/fixtures/expected_result.yml') }
  let(:service)         { XmlParserService.new(data) }

  describe "initialization" do
    it "initializes with data string" do
      expect { XmlParserService.new(data) }.not_to raise_error
    end
  end

  describe "attr_readers" do
    it "defines reader for :data" do
      expect(service.data).to eq data
    end
  end

  describe "#parse" do
    subject { service.parse }

    it "creates all Listing's available in data file" do
      expect { subject }.to change(Listing, :count).by(3)

      expected_result.each do |expected_listing|
        listing = Listing.find_by(start_time: expected_listing['start_time'])
        expect(listing.attributes.except('created_at', 'updated_at', 'id')).to eq expected_listing
      end
    end

    it "converts CET time zone to UTC" do
      subject
      all_listings = Listing.all
      expect(all_listings.map(&:start_time)).to eq expected_result.map { |e| e['start_time'] }
      expect(all_listings.map(&:end_time)).to eq expected_result.map { |e| e['end_time'] }
    end
  end
end
