require 'sinatra'
require './multiple-choice'
require './helpers'
require 'json'

Q_AND_A_DATA = Game.parse_data_file

get '/' do
  # set the question and correct answer
  @question, correct_answer = Game.random_q_and_a Q_AND_A_DATA
  # buils array of specified number of incorrect answers
  incorrect_answers = Game.random_incorrect_answers 3, correct_answer, Q_AND_A_DATA.values
  # puts correct and incorrect answers into one array
  choices = ([correct_answer] + incorrect_answers).shuffle
  # returns array pairs of answers with letters
  @answers = Game.choices_from_answers choices
  erb :index #, :locals =>
end


post '/evaluate_question' do
  body_params = JSON.parse request.body.read
  #take the user's inut
  user_choice = Game.parse_choice (body_params["user_choice"])
  question = body_params["question"]
  choices = body_params["choices"].map {|choice_pair| [choice_pair[0].to_sym, choice_pair[1]] }
  # id the correct answer
  correct_answer = Q_AND_A_DATA[question]
  # and evaluate against the correct answer
  result = Helpers.titleize(Game.evaluate user_choice, correct_answer, choices)
  # send result as JSON object
  content_type :json
  {'result' => result, 'question' => question,'correct' => correct_answer}.to_json
end



