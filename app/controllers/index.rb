require 'sinatra'
require_relative '../../config/environment'

get '/' do
  erb :index
end


post '/urls' do
  @url = Url.create(long_url: params[:long_url])
  p @url
  if @url.persisted?
    if request.xhr?
      erb :url_partial, :layout => false
    else
      redirect :'/'
    end
  else
    status 420
  end
end

get '/:short_url' do
  @url_created =  Url.find_by(short_url: params[:short_url])
  @url_created.click_count += 1
  @url_created.save
    redirect to(@url_created.long_url)
end

# Additional route just to get click counts
get '/cc/:surl' do
  @url =  Url.find_by(short_url: params[:surl])
  if request.xhr?
    content_type :json
    {click_count: @url.click_count}.to_json
  else
    redirect '/'
  end
end
