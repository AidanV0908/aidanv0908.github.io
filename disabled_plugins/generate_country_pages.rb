module Jekyll
    class CountryPageGenerator < Generator
      safe true
  
      def generate(site)
        # Get the countries from the _config.yml file
        countries_visited = site.config["countries_visited"] || []
        countries_lived = site.config["countries_lived"] || []
  
      # Combine into one dataset with a status for each country
      countries = countries_visited.map { |country| { "name" => country["name"], "code" => country["code"], "description" => country["description"], "status" => "visited" } } +
                  countries_lived.map { |country| { "name" => country["name"], "code" => country["code"], "description" => country["description"], "status" => "lived" } }

            # Generate a page for each country
            countries.each do |country|
                country_name = country["name"] # Extract the name
                country_code = country["code"] # Extract the code
                country_description = country["description"] # Extract the description
                status = country["status"]    # Extract the status

                site.pages << CountryPage.new(site, site.source, country_name, country_code, country_description, status)
            end
        end
    end
  
    class CountryPage < Page
        def initialize(site, base, country_name, country_code, country_description, status)
          @site = site             # Current Jekyll site instance
          @base = base             # Path to the source directory
          @dir  = "Country/#{country_name}" # Directory for the generated page
          @name = "index.html"     # Filename for the generated page
      
          self.process(@name)      # Set the filename
          self.read_yaml(File.join(base, "_layouts"), "country_category.html") # Use category.html layout
          self.data["title"] = country_name  # Set the title to the country name
          self.data["category"] = country_name.downcase # Set the category
          self.data["description"] = country_description
          self.data["status"] = status
        end
      end
  end
  