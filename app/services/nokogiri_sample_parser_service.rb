class NokogiriSampleParserService
  attr_reader :data

  # Service initiates with the file content of spec/fixtures/nokogiri-sample.xml
  def initialize(data)
    @data = data
  end

  def parse
    document = Nokogiri::XML(data)

    document.xpath("//listing").each do |listing|
      Listing.create!(
        start_time: listing.attribute('start').value,
        end_time: listing.attribute('stop').value,
        title: listing.xpath('title').text,
      )
    end
  end
end
