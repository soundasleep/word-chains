class CommonCharacters
  def initialize(length)
    @length = length
  end

  def common(a, b)
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
    elsif @length == 6
      (a[0] == b[0] ? 1 : 0) +
        (a[1] == b[1] ? 1 : 0) +
        (a[2] == b[2] ? 1 : 0) +
        (a[3] == b[3] ? 1 : 0) +
        (a[4] == b[4] ? 1 : 0) +
        (a[5] == b[5] ? 1 : 0)
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
end