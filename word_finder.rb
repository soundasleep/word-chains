require_relative "common_characters"

class WordFinder < AStar
  def initialize(dictionary)
    @dictionary = dictionary
    @length = @dictionary.words[0].length
    @neighbours = {}
  end

  def estimate_distance(start, goal)
    distance_between(start, goal)
     # + (1 / (1 + neighbours(start).count))
  end

  def distance_between(a, b)
    return 2 / (1 + (characters_in_common(a, b) ** 2))
  end

  def characters_in_common(a, b)
    common_characters.common(a, b)
  end

  def neighbours(word)
    @neighbours[word] ||= @dictionary.words.select do |w|
        w != word && characters_in_common(word, w) == word.length - 1
    end
  end

  private

  def common_characters
    @common_characters ||= CommonCharacters.new(@length)
  end

end
