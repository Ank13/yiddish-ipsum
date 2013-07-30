module Helpers

  extend self

  def symbolize_keys(hash)
    hash.keys.each do |key|
      hash[(key.to_sym rescue key) || key] = hash.delete(key)
    end
    hash
  end

  def titleize(words)
    words = words.to_s.strip.downcase.split(' ')
    words.each do |word|
      word[0] = word[0].upcase
    end
    words.join(' ')
  end
end

if $0 == __FILE__
  p Helpers.titleize("george washington")
  p Helpers.titleize(:correct)
end
