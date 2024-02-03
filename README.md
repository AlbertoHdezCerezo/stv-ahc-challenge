# README

### Getting started
In a terminal run `docker compose up -d` to boot your local environment.
The system is dependant on [Docker](https://www.docker.com) being preinstalled.

To utilize your time best possible, we suggest you run `docker compose up -d` now and continue reading this README while docker is booting your container.

#### Remove containers when done
When you're done with the assignment, you can remove the containers by running `docker compose down`.

### Assignment
Your assignment is to create 3 parsers to parse the following three data files:
- `app/services/json_parser_service.rb` should parse `spec/fixtures/data.json`
- `app/services/xml_parser_service.rb` should parse `spec/fixtures/data.xml`
- `app/services/html_parser_service.rb` should parse `spec/fixtures/data.html`

Each data sample contains the exact same data and you can see the expected result in `spec/fixtures/expected_result.yml`.

The `#parse` method will access the data file's content via the `data` variable and from there you should create `Listing`s for each entry in the respective data file.

Take a look at the NokogiriSampleParserService for an example of a succesful parser implementation. It uses Nokogiri to parse XML, which can be used to parse HTML as well.

`Listing`'s data schema is as follows:
```ruby
  create_table "listings", charset: "utf8", force: :cascade do |t|
    t.string "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "description"
    t.string "image_url"
    t.integer "episode_number"
    t.integer "season_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```

### Running the tests
You can run rspec for a specific service like this `docker/rspec spec/services/json_parser_service_spec.rb`.
Or you can run `docker/rspec` to test all services at once.

Complete the code in above three parsers to complete the assignment.

You'll face the following expectations:
```rspec
HtmlParserService
  #parse
    creates all Listing's available in data file (FAILED - 1)
    parses end_time of current listing from next listings start_time (FAILED - 2)
    converts HTML encodings from descriptions (FAILED - 3)

JsonParserService
  #parse
    creates all Listing's available in data file (FAILED - 4)
    parses episode number out of data title (FAILED - 5)
    doesn't parse episode number when not available from title (FAILED - 6)

XmlParserService
  #parse
    creates all Listing's available in data file (FAILED - 7)
    converts CET time zone to UTC (FAILED - 8)
```

##### You have 2 hours to complete as many tasks as possible.
We'll evaluate both the code you produce as well as the completeness of the specs. Do not worry if you cannot complete all assignments in time. Do your best to complete as much as possible, but when don't sweat it if you cannot complete the full assignment. Even some of our experienced engineers in Simply.TV has spend more han 2 hours to complete the full test.

Once you have completed your assignments, please zip the directory of this Rails application again, and return the zip file to Simply.TV for a review. Please ensure to include your changes.
