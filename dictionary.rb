# Stores all words of length X
class Dictionary
  attr_reader :words

  def initialize(length)
    @words = []

    File.open("/usr/share/dict/words", "r") do |f|
      f.each_line do |line|
        line.strip!
        if line.length == length
          add line.downcase
        end
      end
    end
  end

  def add(word)
    @words << word
  end
end
