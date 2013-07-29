# Flashcard quiz with foreign language phrases and translations

module Game

  extend self

  DEFAULT_DATA_FILE = 'sayings3.txt'

  def parse_data_file file=File.open(Game::DEFAULT_DATA_FILE, 'r')
    file_data = Hash.new
      file.each_line do |line|
        # split each line from the file at the tab
        line_data = line.split(/\t/)
        # create a hash, with the Yiddish (position 1) as the key
        file_data[line_data[1].chomp] = line_data[0]
    end
    file_data
  end

  def random_q_and_a hash
    # take a random key (definition) from the list
    random_key = hash.keys.sample
    # return an array of the definition and translation
    [random_key, hash[random_key]]
  end

  def random_incorrect_answers number, correct_answer, all_answers
    incorrect_answers = []
    until incorrect_answers.length == number
      # until we have the amount requested, get a random answer
      random_answer = all_answers.sample
      # and if it does not match the correct answer, put into array
      incorrect_answers << random_answer if random_answer != correct_answer
    end
    incorrect_answers
  end

  def choices_from_answers answers
    letters, choices = ('a'..'z').to_a, []
    # pair each answer with a letter, i.e. [a:, "possible answer"]
    answers.each_with_index {|answer, i| choices << [letters[i].to_sym, answer]}
    # return array pairs
    choices
  end

  def format_choices choices
    formatted_choices = []
    choices.each do |choice|
      # join upcased letters with answers
      formatted_choices << "#{choice[0].upcase}: #{choice[1]}"
    end
    formatted_choices
  end

  def parse_choice user_input
    # remove whitespace, downcase, and make a symbol
    user_input.strip.downcase.to_sym
  end

  def evaluate user_choice, correct_answer, choices
    # find the answer that the user chose
    selected_answer = choices.find{|choice| choice[0] == user_choice}
    return :invalid if selected_answer.nil?
    # compare to the correct answer
    return :correct if selected_answer[1] == correct_answer
    return :incorrect if selected_answer[1] != correct_answer
  end

end

if $0 == __FILE__

  q_and_a_data =
    Game.parse_data_file File.open(Game::DEFAULT_DATA_FILE, 'r') # think r is default

  question, correct_answer = Game.random_q_and_a q_and_a_data

  all_answers = q_and_a_data.values
  incorrect_answers = Game.random_incorrect_answers 2, correct_answer, all_answers

  puts question
  puts
  answers = [correct_answer] + incorrect_answers
  answers = answers.shuffle

  choices = Game.choices_from_answers answers # [[:a, "some answer"], [:b, ""]]
  puts Game.format_choices choices
  puts
  puts "Enter the letter of the correct translation"
  puts
  user_choice = Game.parse_choice gets.chomp # "   A   " => :a

  case Game.evaluate user_choice, correct_answer, choices
  when :invalid
    puts "That's not a valid selection"
  when :correct
    puts "Correct!"
  when :incorrect
    puts "Wrong, the correct answer was '#{correct_answer}'"
  end

end
