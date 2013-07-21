# Yiddish Sayings Generator

# Allows us to generate blocks of yiddish sayings from an array parsed from a sources found on the internet

# Source 1: http://kehillatisrael.net/docs/yiddish/yiddish_pr.htm

module Sayings

  extend self

  SAYINGS = File.read('sayings3.txt').
  # split the file into lines
  lines.
  # remove the new line breaks
  map(&:chomp)

  def random_saying
    SAYINGS.sample
  end

  def english_saying
    # get just the English portion of the line
    random_saying.split("\t").first + ' '
  end

  def yiddish_saying
    # get just the Yiddish portion of the line
    random_saying.split("\t").last + ' '
  end

  def yiddish_with_translation
    random_saying.
    # separate english and yiddish into array
    split("\t")
  end

  def yipsum(args)
    length = args.fetch(:length).to_i
    language = args.fetch(:language)
    yipsum_block = []
    # retrieve the requested number of phrases
    length.times do
      # retrieve in the requested language
      case language
      when "english"
        yipsum_block << Sayings.english_saying
      when "yiddish"
        yipsum_block <<  Sayings.yiddish_saying
      else
        saying = Sayings.yiddish_with_translation
        yipsum_block <<  "#{saying.last} #{saying.first} "
      end
    end
    # join retrieved phrases into one string
    yipsum_block.join('')
  end

end


if $0 == __FILE__

  puts "Nu, how many lines do you want?"
  lines_requested = gets.chomp.to_i

  puts "English, Yiddish, or both?"
  language = gets.chomp.downcase

  puts Sayings.yipsum({language: language, length: lines_requested})

end
