require 'json'
require 'erb'

airports_file = 'airports.json'
airports_json = File.read(airports_file)
airports = JSON.parse(airports_json)

@matching = airports.select { |a| a['iata'].include?(ARGV[0].to_s.upcase) }

erb = <<XML
<?xml version="1.0"?>
<items><% @matching.each do |airport| %>
  <item uid="<%= airport['iata'] %>" arg="<%= airport['name'] %>" valid="yes">
    <title><%= airport['name'] %></title>
    <subtitle><%= airport['latitude'] %>, <%= airport['longitude'] %></subtitle>
    <icon></icon>
  </item><% end %>
</items>
XML

puts ERB.new(erb).result(binding)
