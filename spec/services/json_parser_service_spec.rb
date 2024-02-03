require 'rails_helper'

RSpec.describe JsonParserService, type: :services do
  let(:data)            { File.read('spec/fixtures/data.json') }
  let(:expected_result) { YAML.load_file('spec/fixtures/expected_result.yml') }
  let(:service)         { JsonParserService.new(data) }

  describe "initialization" do
    it "initializes with data string" do
      expect { JsonParserService.new(data) }.not_to raise_error
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

    it "parses episode number out of data title" do
      subject
      listing = Listing.find_by(start_time: expected_result[0]['start_time'])
      expect(listing.title).to eq expected_result[0]['title']
    end

    it "doesn't parse episode number when not available from title" do
      subject
      listing = Listing.find_by(start_time: expected_result[1]['start_time'])
      expect(listing.episode_number).to be_blank
    end
  end
end
