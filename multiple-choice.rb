# Presents user saying and multiple-choice of translation

module Game

  extend self

  SAYINGS = File.read('sayings3.txt').
  # split source file into lines
  lines.
  # remove new line breaks
  map(&:chomp)

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
    start = line + 1 if line <= SAYINGS.length - 3
    start = line - 4 if line > SAYINGS.length - 3

    wrong_answers = []

    (start).upto(start+3) do |i|
      wrong_answers << answer(i)
    end
    wrong_answers
  end

  def answer_choices(line)
    (incorrect_answers(line) << answer(line)).
    # shuffles the answers
    shuffle.
    # puts a letter in front of each answer
    map{|answer| "A: #{answer}"}
  end

end


if $0 == __FILE__

  # puts Game::SAYINGS.length
  line = Game.select_question

  puts Game.question(line)
  # Game.incorrect_answers(line)
  # Game.answer(line)
  puts Game.answer_choices(line)


end
