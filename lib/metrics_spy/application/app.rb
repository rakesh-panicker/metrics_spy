require 'sinatra'
require 'data_mapper'
require 'json'
require 'sinatra/config_file'
require 'sinatra/respond_with'

#DataMapper::setup(:default, "sqlite3://#{File.expand_path(__FILE__)}/lib/metrics_spy/application/database/metrics_spy.db")

DataMapper.setup(:default, "sqlite3::memory:")


class Metric
  include DataMapper::Resource
  property :id, Serial
  property :data, Text, :required => true
  property :created_at, DateTime
end


DataMapper.finalize.auto_upgrade!


class MetricsSpy < Sinatra::Base

  use Rack::MethodOverride
  set :static, true                             # set up static file routing
  set :public_folder, File.expand_path('..', __FILE__) # set up the static dir (with images/js/css inside)

  set :views,  File.expand_path('../views', __FILE__) # set up the views dir

  configure :production do
    enable :logging
    set :server, %w[thin mongrel webrick]
    set :port, 9191
    puts 'Metrics Spy :: Production Environment'
  end

  configure :development do
    set :server, %w[thin mongrel webrick]
    set :port, 9191
    enable :logging
    puts 'Metrics Spy :: Development Environment'
  end

  helpers do
    include Rack::Utils
    alias_method :make_valid_string, :escape_html
  end

  SITE_TITLE = "The Metrics Spy"
  SITE_DESCRIPTION = "I’m not spying! I’m evaluating !"

  get '/' do
    @all_metrics = Metric.all
    erb :'/home'
  end


  get '/eluminate' do
    unless params.empty?
      metric = Metric.new
      metric.data = params.to_s
      metric.created_at = Time.now
      metric.save
    end
    redirect '/'
  end

  get '/getmetrics' do
    @metrics =  Metric.all
    content_type :json
    if @metrics.empty?
      { :content => 'No metrics recorded.' }.to_json
    else
      response = { :content => Array(@metrics)}.to_json
      delete_all_metrics
      response
    end
  end

  def delete_all_metrics
    Metric.destroy
  end

end

#MetricsSpy.run!