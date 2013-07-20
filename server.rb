require 'sinatra'
require './generator'

get '/' do
  @saying = Sayings.yiddish_with_translation
  erb :index
end
