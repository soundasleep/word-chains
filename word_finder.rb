class WordFinder < AStar
  def initialize(dictionary)
    @dictionary = dictionary
  end

  def estimate_distance(start, goal)
    distance_between(start, goal)
  end

  def distance_between(a, b)
    1 / ((1 + characters_in_common(a, b)) ** 2)
  end

  def characters_in_common(a, b)
    # the number of characters in common
    sum = 0
    (0...a.length).each do |n|
      sum += 1 if a[n] == b[n]
    end
    sum
  end

  def neighbours(word)
    @dictionary.words.select do |w|
      w != word && characters_in_common(word, w) == word.length - 1
    end
  end
end
