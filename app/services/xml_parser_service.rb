class XmlParserService
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def parse
    listings_payload = Nokogiri::XML(data).xpath("//listing").map { listing_payload(_1) }
    Listing.insert_all!(listings_payload)
  end

  private

  def listing_payload(xml_data_item)
    {
      start_time: to_utc_timestamp(date(xml_data_item), xml_data_item.attribute("start").value, time_zone(xml_data_item)),
      end_time: to_utc_timestamp(date(xml_data_item), xml_data_item.attribute("stop").value, time_zone(xml_data_item)),
      title: xml_data_item.xpath("title").text,
      description: xml_data_item.xpath("description").text,
      episode_number: xml_data_item.xpath("episode").text,
      season_number: xml_data_item.xpath("episode").attribute("season")&.value,
      image_url: xml_data_item.xpath("image").text
    }
  end
  
  def date(xml_data_item) = xml_data_item.attribute("date").value.to_date

  def time_zone(xml_data_item) = xml_data_item.attribute("tz").value

  def to_utc_timestamp(date, time, time_zone)
    ActiveSupport::TimeZone[time_zone].parse("#{date} #{time}").utc
  end
end
