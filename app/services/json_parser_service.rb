class JsonParserService
  attr_reader :data

  # Service initiates with the file content of spec/fixtures/data.json
  def initialize(data)
    @data = data
  end

  def parse
    # TODO: Please write parsing method to parse the contents of spec/fixtures/data.json into Listing records.
  end
end
