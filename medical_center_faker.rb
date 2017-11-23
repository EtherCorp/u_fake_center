require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
Dir[File.expand_path 'centers/**/*.rb'].each{|f| require_relative(f)}

class MedicalCenterFaker
  attr_reader :uri
  attr_reader :async

  def initialize(target_uri = 'http://localhost:3001/api/v1/', async_requests = TRUE)
    @uri = URI.parse(target_uri)
    @async = async_requests
  end

  def post_request(endpoint, token, body)
    header = { 'Content-Type': 'application/json', 'Medical-Center-Token': token }
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path + endpoint, header)
    request.body = body.to_json
    response = http.request(request)
    puts response.inspect
  end

  def run_async(requests)
    threads = []
    requests.each do |request|
      request_type = request[:request_type]
      request_source = request[:source]
      request_endpoint = request[:endpoint]

      puts "#{request_source}: #{request_type} -> #{request_endpoint}"

      (1..request[:request_number]).each do
        medical_center = Object.const_get(request_source)
        request_body = medical_center.public_send(request_type)
        token = medical_center.token
        puts request_body.to_json
        threads << Thread.new do
          post_request(request_endpoint, token, request_body)
        end
      end
    end

    threads.each { |thread| thread.join }
  end

  def run_sync(requests)
    requests.each do |request|
      request_type = request[:request_type]
      request_source = request[:source]
      request_endpoint = request[:endpoint]

      puts "#{request_source}: #{request_type} -> #{request_endpoint}"

      (1..request[:request_number]).each do
        medical_center = Object.const_get(request_source)
        request_body = medical_center.public_send(request_type)
        token = medical_center.token
        puts request_body.to_json
        post_request(request_endpoint, token, request_body)
      end
    end
  end

  def run(requests)
    run_async requests if async
    run_sync requests unless async
  end
end

