class HtmlParserService
  attr_reader :data

  # Service initiates with the file content of spec/fixtures/data.html
  def initialize(data)
    @data = data
  end

  def parse
    # TODO: Please write parsing method to parse the contents of spec/fixtures/data.html into Listing records.
  end
end
