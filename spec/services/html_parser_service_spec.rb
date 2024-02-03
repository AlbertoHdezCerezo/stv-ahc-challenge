require 'rails_helper'

RSpec.describe HtmlParserService, type: :services do
  let(:data)            { File.read('spec/fixtures/data.html') }
  let(:expected_result) { YAML.load_file('spec/fixtures/expected_result.yml') }
  let(:service)         { HtmlParserService.new(data) }

  describe "initialization" do
    it "initializes with data string" do
      expect { HtmlParserService.new(data) }.not_to raise_error
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

    it "parses end_time of current listing from next listings start_time" do
      subject
      all_listings = Listing.order(:start_time)

      expect(all_listings.first.start_time).to eq expected_result[0]['start_time']
      expect(all_listings.first.end_time).to eq expected_result[0]['end_time']
      expect(all_listings.second.start_time).to eq expected_result[1]['start_time']
      expect(all_listings.second.end_time).to eq expected_result[1]['end_time']
      expect(all_listings.third.start_time).to eq expected_result[2]['start_time']
      expect(all_listings.third.end_time).to eq expected_result[2]['end_time']
    end

    it "converts HTML encodings from descriptions" do
      subject
      listing = Listing.order(start_time: :desc).take
      expect(listing.description).to eq expected_result[2]['description']
    end
  end
end
