class JsonParserService
  attr_reader :data

  # Service initiates with the file content of spec/fixtures/data.json
  def initialize(data)
    @data = data
  end

  def parse
    listings_payload = JSON.parse(data).map { listing_payload(_1) }
    Listing.insert_all!(listings_payload)
  end

  private

  def listing_payload(json_data_item)
    {
      start_time: json_data_item.dig("schedule", "start"),
      end_time: json_data_item.dig("schedule", "stop"),
      title: title(json_data_item),
      description: json_data_item["description"],
      episode_number: episode_number(json_data_item),
      season_number: json_data_item["season"],
      image_url: json_data_item["image"]
    }
  end

  def payload_title(json_data_item) = json_data_item["title"]

  def title(json_data_item) = payload_title(json_data_item).sub(/\s\(\d+\)$/, '')

  def episode_number(json_data_item)
    payload_title(json_data_item)[/\((\d+)\)$/, 1] || nil
  end
end
