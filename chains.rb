#!/usr/bin/env ruby

require_relative "dictionary"
require_relative "a_star"
require_relative "word_finder"

start_word = ARGV[0]
end_word = ARGV[1]

if !(start_word && end_word)
  fail "Expected arguments: [start_word] [end_word]"
end

if start_word.length != end_word.length
  fail "Those two words are not the same length"
end

def find_path(start_word, end_word)
  # for shorter paths
  starting_minimum_exact_match = start_word.length / 2
  starting_minimum_match = start_word.length / 2

  # for faster execution
  # starting_minimum_exact_match = 0
  # starting_minimum_match = 3

  starting_minimum_exact_match.downto(0).each do |minimum_match|
    starting_minimum_match.downto(minimum_match).each do |minimum_exact_match|

      puts "trying #{minimum_match}/#{minimum_exact_match}..."

      # load the dictionary for all words of X length
      dictionary = Dictionary.new(start_word.length, start_word, end_word, minimum_match, minimum_exact_match)
      # puts "dictionary has #{dictionary.words.count} words"

      fail "Word '#{start_word}' is not in the dictionary" unless dictionary.words.include?(start_word)
      fail "Word '#{end_word}' is not in the dictionary" unless dictionary.words.include?(end_word)

      finder = WordFinder.new(dictionary)

      # now use a* to find the shortest path
      # start from the word with the most neighbours
      if finder.neighbours(end_word).length > finder.neighbours(start_word).length
        result = finder.a_star(end_word, start_word)
        return result.reverse if result != nil
      else
        result = finder.a_star(start_word, end_word)
        return result if result != nil
      end
    end
  end

  fail "Could not find a path"
end

result = find_path(start_word, end_word)

puts "result = #{result}"
puts "(#{result.count} nodes)"

# Things that don't improve performance
# 1. Loading the dictionary in the WordFinder for each neighbour
# 2. Caching neighbours or characters_in_common in WordFinder
# 3. Only calling strip! on words of length (length + 1) in Dictionary
# 4. Using a Set instead of an Array for Dictionary.words
# 5. Using an exponent of 1 instead of 2 in distance_between
# 6. Providing different exponents for estimate_distance and distance_between
# 7. Storing a dictionary as chars instead of strings
# 8. Sorting the word list by frequency of common characters
