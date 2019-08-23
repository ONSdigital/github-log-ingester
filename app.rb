# frozen_string_literal: true

require 'json'
require 'time'
require 'sinatra'
require 'sinatra/flash'

TEN_MINUTES = 60 * 10
use Rack::Session::Pool, expire_after: TEN_MINUTES

# Turn off request logging
set :logging, false

before do
  headers 'Content-Type' => 'text/html; charset=utf-8'
end

get '/?' do
  erb :index, locals: { title: 'GitHub Audit Log Ingester' }
end

post '/upload' do
  if params[:file].nil?
    flash[:notice] = 'No GitHub audit log JSON export file selected for upload.'
    redirect '/'
  end

  filename = params[:file][:filename]
  temp_file = "./public/#{filename}"

  unless params[:file][:type].eql?('application/json')
    flash[:notice] = 'File must be a GitHub audit log JSON export.'
    redirect '/'
  end

  File.open(temp_file, 'w+t') do |f|
    f.write(params[:file][:tempfile].read)
  end

  lines = JSON.parse(File.read(temp_file))
  unless lines
    flash[:notice] = 'Unable to parse uploaded GitHub audit log JSON export.'
    redirect '/'
  end

  line_num = 0
  lines.each do |line|
    line_num += 1
    unless line['org']
      flash[:notice] = "File isn't a valid GitHub audit log export (missing 'org' key on line #{line_num})."
      redirect '/'
    end

    # Convert UNIX Epoch time to a more readable format.
    line['created_at'] = Time.strptime(line['created_at'].to_s, '%Q')
    puts line.to_json
  end

  File.delete(temp_file) if File.exist?(temp_file)

  flash[:notice] = "Successfully ingested #{filename}."
  redirect '/'
end
