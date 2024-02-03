class HtmlParserService
  attr_reader :data

  # Service initiates with the file content of spec/fixtures/data.html
  def initialize(data)
    @data = data
  end

  def parse
    parsed_html = Nokogiri::HTML(data)
    listings_payload = parsed_html.css("section").map { listing_payload(parsed_html, _1) }
    Listing.insert_all!(listings_payload)
  end

  private

  def listing_payload(html, html_data_item)
    season_and_episode = html_data_item.css("h3 small").text

    {
      start_time: html_data_item.css("h3 time").text,
      end_time: html_data_item.css("img").attributes["src"].value,
      title: html_data_item.css("h3 strong").text,
      description: html_data_item.css("p").text,
      episode_number: season_and_episode[/^S\d+E(\d+)$/, 1],
      season_number: season_and_episode[/S(\d+)E(\d+)/, 1],
      image_url: html_data_item.css("img").attributes["src"].value
    }
  end
end
