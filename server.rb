require 'sinatra'
require './generator'
require './helpers'

get '/' do
  @saying = Sayings.yiddish_with_translation
  erb :index
end

post '/nu' do
  # convert param keys from strings to sybmols
  requested_block = Helpers.symbolize_keys(params)
  # get the block of yiddish ipsum
  @yipsum_block = Sayings.yipsum(requested_block)

  if request.xhr?
    erb :_yipsum, :layout => false
  else
    erb :yipsum
  end

end



