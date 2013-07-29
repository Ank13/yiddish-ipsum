require 'sinatra'
require './multiple-choice'
require './helpers'

get '/' do
  q_and_a_data = Game.parse_data_file
  @question, @correct_answer = Game.random_q_and_a q_and_a_data

  all_answers = q_and_a_data.values
  incorrect_answers = Game.random_incorrect_answers 2, @correct_answer, all_answers
  @answers = [@correct_answer] + incorrect_answers

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



