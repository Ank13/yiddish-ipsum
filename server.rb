require 'sinatra'
require './multiple-choice'
require './helpers'

get '/' do
  @line = Game.select_question
  @question = Game.question(@line)
  @answers = Game.answer_choices(@line)
  erb :index
end

# post '/nu' do
#   # convert param keys from strings to sybmols
#   requested_block = Helpers.symbolize_keys(params)
#   # get the block of yiddish ipsum
#   @yipsum_block = Sayings.yipsum(requested_block)

#   if request.xhr?
#     erb :_yipsum, :layout => false
#   else
#     erb :yipsum
#   end

# end



