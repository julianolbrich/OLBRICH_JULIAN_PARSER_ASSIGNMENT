require 'csv'
  # Address.destroy_all
  # Flat.destroy_all

# STEP 1: Parse CSV with addresses from textfile
  filepath = 'db/addresses.csv'
  addresses_from_textfile = []

  CSV.foreach(filepath) do |row|
    addresses_from_textfile.push(row)
  end


# STEP 2: Normalize data with Regex, focus on: street, housenumber, postalcode, city
    @parsed_input = []
    addresses_from_textfile.each do |addresse|

    # (1) Input     => with all information given
      input = addresse.first

    # (2) Address   => with Street and Housenumber
      # covers all street-number combos, i.e.
        # Vogelthenne 12 b
        # E.-Steinfurth-Str. 47/48
        # Schäferstraße 23-24
        # Auf der Bult 10
      address_str = addresse.to_s.match(/[a-zA-ZäöüÄÖÜß\.\-]+[ ]?[a-zA-ZäöüÄÖÜß\.\-]+[ ]?[a-zA-ZäöüÄÖÜß\.\-]+[ ][0-9]{1,3}([ ]?-?[ ]?[0-9]{0,2})(\/?[0-9]{0,2})(([ ][a-zA-Z])|([a-zA-Z]?|)?)/).to_s
      # cleaning 'str.' into 'straße' for Algolia
      if address_str.include? 'Str.'
        address = address_str.sub('Str.', 'Straße')
      elsif address_str.include? 'str.'
        address = address_str.sub('str.', 'straße')
      elsif address_str.include? 'str '
        address = address_str.sub('str ', 'straße ')
      elsif address_str.include? 'Str '
        address = address_str.sub('Str ', 'Straße ')
      elsif address_str.include? 'St.'
        address = address_str.sub('St.', 'Sankt')
      else
        address = address_str
      end

    # (3) Street
      street = address.match(/[a-zA-ZäöüÄÖÜß\.\-]+[ ]?[a-zA-ZäöüÄÖÜß\.\-]+[ ]?[a-zA-ZäöüÄÖÜß\.\-]/).to_s
      street.titleize

    # (4) Housenumber - in two forms:
      number_complete = address.sub(street,"").strip
      # NOTE: ALGOLIA DOESNT WORK WELL WITH "12 b" or "47/48"
      # for presentation purposes, i therefore clean 'number' so that
        # i.e. Schäferstraße 23-24 => Schäferstraße 23
        # i.e. E.-Steinfurth-Str. 47/48 => E.-Steinfurth-Str. 47
      number_cleaned = address.match(/[0-9]{1,3}/).to_s

    # (5) Postal Code
      plz = addresse.to_s.match(/[0-9]{5}/).to_s

    # (6) city
      # I first planned on getting city via Algolia, but it doesnt take postal code as argument
      # hence my workaround, which should cover almost all cases:
      postcode_and_city = addresse.to_s.match(/[0-9]{5}+[ ]+[a-zA-ZäöüÄÖÜß\-]+/).to_s
      city = postcode_and_city.sub(plz,"").strip.titleize
      if city == ""
        city2 = addresse.to_s.match(/[^(, )]*$/).to_s
        city = city2.match(/\w*/).to_s
        city.strip.titleize
      end

    # (7) "the rest", remaining info (i.e. streets without housenumber, "Templiner Vorstadt", ..) and some cleaning
      addresszusatz_9 = input
      addresszusatz_8 = addresszusatz_9.gsub(address_str, "")
      addresszusatz_7 = addresszusatz_8.gsub(postcode_and_city, "")
      addresszusatz_6 = addresszusatz_7.gsub(",  , ", "")
      addresszusatz_5 = addresszusatz_6.gsub(",  ", "")
      addresszusatz_4 = addresszusatz_5.gsub(", ,", "")
      addresszusatz_3 = addresszusatz_4.gsub(",   / ", "")
      addresszusatz_2 = addresszusatz_3.gsub(",  / ", "")
      addresszusatz_1 = addresszusatz_2.gsub(",   ", "")
      addresszusatz = addresszusatz_1.gsub("/ ", "")
      addresszusatz.strip!

      homeday_input_normalized = { input: input, address: address, street: street, number: number_cleaned, number_full: number_complete, plz: plz, city: city, addresszusatz: addresszusatz }
      @parsed_input << homeday_input_normalized
    end

# STEP 3: Seed addresses to provide API with JSON output of the normalized test-addresses
    @parsed_input.each do |row|
      Address.create(
        input: row[:input],
        address: row[:address],
        street: row[:street],
        number: row[:number],
        number_full: row[:number_full],
        plz: row[:plz],
        city: row[:city],
        addresszusatz: row[:addresszusatz]
      )

      address_for_algolia = row[:street] + " " + row[:number] + " " + row[:city]

      # send directly to Geocoder API with goal: add district & state
      sleep 1
      Flat.create(
        address: address_for_algolia,
        street_number: row[:number],
        street: row[:street],
        postal_code: row[:plz],
        city: row[:city]
      )
    end

    puts "Now #{Address.count} rows in the address table."
    puts "Now #{Flat.count} rows in the flats table."
