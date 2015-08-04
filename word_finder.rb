class WordFinder < AStar
  def initialize(dictionary)
    @dictionary = dictionary
    @length = @dictionary.words[0].length
  end

  def estimate_distance(start, goal)
    distance_between(start, goal)
  end

  def distance_between(a, b)
    return 1 / (1 + (characters_in_common(a, b) ** 2))
  end

  def characters_in_common(a, b)
    if @length == 3
      (a[0] == b[0] ? 1 : 0) +
        (a[1] == b[1] ? 1 : 0) +
        (a[2] == b[2] ? 1 : 0)
    elsif @length == 4
      (a[0] == b[0] ? 1 : 0) +
        (a[1] == b[1] ? 1 : 0) +
        (a[2] == b[2] ? 1 : 0) +
        (a[3] == b[3] ? 1 : 0)
    elsif @length == 5
      (a[0] == b[0] ? 1 : 0) +
        (a[1] == b[1] ? 1 : 0) +
        (a[2] == b[2] ? 1 : 0) +
        (a[3] == b[3] ? 1 : 0) +
        (a[4] == b[4] ? 1 : 0)
    else
      remaining_characters_in_common(a, b)
    end
  end

  def remaining_characters_in_common(a, b)
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
