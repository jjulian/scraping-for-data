# Pull GPS info from a directory of images, and output an html page
# that uses the Google Maps API to show them on a map.

require 'rubygems'
require 'exifr'
require 'json'
require 'erb'

# Add JSON capability to Struct, since the exifr gem returns gps data as a Struct
# http://ruhe.tumblr.com/post/565540643/generate-json-from-ruby-struct
class Struct
  def to_map
    map = Hash.new
    self.members.each { |m| map[m] = self[m] }
    map
  end

  def to_json(*a)
    to_map.to_json(*a)
  end
end


directory = "photos"
photos = Dir.entries(directory).map do |file|
  next unless file.downcase =~ /\.jpg$/
  full_fname = [directory,file].join('/')
  metadata = EXIFR::JPEG.new(full_fname)
  metadata.gps.to_map.merge(filename: full_fname)
end.compact

photos = JSON.pretty_generate(photos)
puts ERB.new(File.read('photos_template.html.erb')).result(binding)
