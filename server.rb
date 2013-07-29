require 'sinatra'
require './multiple-choice'
require './helpers'

set :sessions, true

get '/' do
  @result = session[:result] if session[:result]
  @previous_answer = session[:correct_answer] if session[:result]
  # parse the file of sayings
  q_and_a_data = Game.parse_data_file
  # read the session and the correct answer
  @question, correct_answer = Game.random_q_and_a q_and_a_data
  session[:correct_answer] = correct_answer
  # get array of all possible answers
  all_answers = q_and_a_data.values
  # buils array of specified number of incorrect answers
  incorrect_answers = Game.random_incorrect_answers 2, correct_answer, all_answers
  # puts correct and incorrect answers into one array
  choices = ([correct_answer] + incorrect_answers).shuffle
  # returns array pairs of answers with letters
  @answers = Game.choices_from_answers choices
  session[:choices] = @answers
  erb :index
end

post '/nu' do
  # get the letter of the user selection
  user_choice = Game.parse_choice (params[:user_choice])
  # evaluates user selection, choices, against the correct answer
  session[:result] = Game.evaluate user_choice, session[:correct_answer], session[:choices]
  redirect '/'
end



