class CsvReader < ApplicationService
  attr_reader :csv_file

  def initialize(csv_file)
    @csv_file = csv_file
  end

  def call
    # csv_file = params[:file]

    CSV.foreach(@csv_file.path, headers: true) do |row|
      next if row["Affiliations"].blank?

      name = row["Name"]
      if name.split.count > 1
        first_name = name.split[0]
        last_name = name.split[1..-1].join(" ")
      else
        first_name = name.split[0]
      end

      gender = row["Gender"].downcase
      if gender == "m"
        gender = "Male"
      elsif gender == "f"
        gender = "Female"
      end

      person = Person.create!(
        first_name: check_titleize(first_name),
        last_name: last_name.present? ? last_name.titleize : nil,
        species: row["Species"],
        gender: gender.capitalize,
        weapon: row["Weapon"].present? ? remove_special_chars(row["Weapon"]) : "None",
        vehicle: row["Vehicle"].present? ? sanitize(row["Vehicle"]) : "None"
      )
      row["Location"].split(", ").each do |location|
        location = Location.find_or_create_by(name: location.strip.titleize)
        person.locations << location
      end

      row["Affiliations"].split(", ").each do |affiliation|
        affiliation = Affiliation.find_or_create_by(name: affiliation.strip)
        person.affiliations << affiliation
      end
    end
  end

  private

  def remove_special_chars(string)
    string.gsub(/[^\w\s]/, "")
  end

  def sanitize(string)
    string == "-1" ? "None" : string
  end

  def check_titleize(name)
    if name.match?(/[0-9\-]/)
      name
    else
      name.titleize
    end
  end
end
