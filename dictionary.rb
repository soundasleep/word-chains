# Stores all words of length X
# ignores uppercase words
class Dictionary
  attr_reader :words

  def initialize(length, a, b, minimum_match)
    @words = []
    combined = (a + b).chars.uniq.to_s

    File.open("/usr/share/dict/words", "r") do |f|
      f.each_line do |line|
        # the optimisation where we only include words that include
        # a character within the start or target words seems to work??
        # the higher the limit, the longer chains you will get,
        # but the faster the algorithm will work
        if line.length - 1 == length && line.count(combined) > minimum_match
          add line.strip
        end
      end
    end
  end

  def add(word)
    @words << word
  end
end
