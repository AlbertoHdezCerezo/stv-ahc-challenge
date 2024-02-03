require 'rails_helper'

RSpec.describe NokogiriSampleParserService, type: :services do
  let(:data)            { File.read('spec/fixtures/nokogiri-sample.xml') }
  let(:expected_result) { YAML.load_file('spec/fixtures/expected_result.yml') }
  let(:service)         { NokogiriSampleParserService.new(data) }

  describe "initialization" do
    it "initializes with data string" do
      expect { NokogiriSampleParserService.new(data) }.not_to raise_error
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
        expect(listing.attributes.except('created_at', 'updated_at', 'id', 'description', 'image_url', 'episode_number', 'season_number'))
        .to eq expected_listing.except('description', 'image_url', 'episode_number', 'season_number')
      end
    end
  end
end
