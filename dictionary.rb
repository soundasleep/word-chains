require_relative "common_characters"

# Stores all words of length X
# ignores uppercase words
class Dictionary
  attr_reader :words

  def initialize(length, a, b, minimum_match, minimum_exact_match)
    @words = []
    @length = length
    combined = (a + b).chars.uniq.to_s

    File.open("/usr/share/dict/words", "r") do |f|
      f.each_line do |line|
        # the optimisation where we only include words that include
        # a character within the start or target words seems to work??
        # the higher the limit, the longer chains you will get,
        # but the faster the algorithm will work
        line.downcase!
        if line.length - 1 == length &&
            all_lowercase(line) &&
            (calculate_characters_in_common(a, line) > minimum_exact_match || calculate_characters_in_common(b, line) > minimum_exact_match) &&
            line.count(combined) > minimum_match
          add line.strip
        end
      end
    end
  end

  def add(word)
    @words << word
  end

  private

  def all_lowercase(word)
    word.match(/^[a-z]+$/)
  end

  def calculate_characters_in_common(a, b)
    common_characters.common(a, b)
  end

  def common_characters
    @common_characters ||= CommonCharacters.new(@length)
  end

end
