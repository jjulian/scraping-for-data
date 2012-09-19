require "net/http"

# Helper method: HTTP GET request
def get(host, path)
  # puts "GET #{host} #{path}"
  Net::HTTP.start(host) do |http|
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(path)
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1"
    request["Accept"] = "*/*"
    # request.basic_auth("username", "password")
    http.request(request)
  end
end

# Helper method: HTTP POST request
def post(host, path, data)
  # puts "POST #{host} #{path}"
  # puts data.inspect
  Net::HTTP.start(host) do |http|
    request = Net::HTTP::Post.new(path)
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1"
    request["Accept"] = "*/*"
    request.set_form_data(data)
    http.request(request)
  end
end

