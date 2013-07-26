# Flashcard quiz with foreign language phrases and translations

module Game

  extend self

  SAYINGS = File.read('sayings3.txt').
  # split source file into lines without newline breaks
  lines.map(&:chomp)

  def select_question
    # select random starting line
    rand(SAYINGS.length)
  end

  def question(line)
    # find the current line
    SAYINGS[line].
    # split on tab and return non-English (position 1)
    split(/\t/)[1]
  end

  def answer(line)
    # find the current line
    SAYINGS[line].
    # split on tab and return English translation (position 0)
    split(/\t/)[0]
  end

  def incorrect_answers(line)
    # get wrong answers from around the same point in file as the phrase
    start = line + 1 if line <= SAYINGS.length - 3
    start = line - 4 if line > SAYINGS.length - 3
    wrong_answers = []
    #put the wrong answers into an array
    (start).upto(start+1) do |i|
      wrong_answers << answer(i)
    end
    wrong_answers
  end

  def answer_choices(line)
    letters, choices = ('A'..'Z').to_a, []
    # mix the correct answer in with the incorrect answers and shuffle
    (incorrect_answers(line) << answer(line)).shuffle.
    # puts a letter in front of each answer for display
    each_with_index{|answer, index| choices << "#{letters[index]} : #{answer}"}
    # return the answers matched to letters
    choices
  end

  def evaluate(user_answer, line, choices)
    # identify which choice user made
    user_selected_answer = choices.select{|answer| answer[0]==user_answer.upcase}
    # check if that was a valid selection
    return nil if user_selected_answer.empty?
    # trim the letter off the answer
    user_selected_answer = user_selected_answer.first[4..-1]
    return true if user_selected_answer == answer(line)
    return false if user_selected_answer != answer(line)
  end

end

if $0 == __FILE__
  # choose a saying and print the Yiddish translation
  line = Game.select_question
  puts Game.question(line)

  # display several possible tranlations
  puts choices = Game.answer_choices(line)
  puts

  # prompt user to choose the correct translation
  puts
  puts "Enter the letter of the correct translation"
  user_answer = gets.chomp
  puts

  # evaluate if user was correct
  case Game.evaluate(user_answer, line, choices)
  when nil
    puts "That's not a valid selection"
  when true
    puts "Correct!"
  when false
    puts "Wrong, the correct answer was '#{Game.answer(line)}'"
  end
end
