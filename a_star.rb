class AStar
  # based on https://en.wikipedia.org/wiki/A%2a_search_algorithm#Pseudocode
  def a_star(start, goal)
    closed_set = []
    open_set = [ start ]
    came_from = {}

    g_score = {}
    h_score = {}
    f_score = {}

    g_score[start] = 0
    h_score[start] = estimate_distance(start, goal)
    f_score[start] = h_score[start]

    while open_set.any? do
      current = lowest_node(open_set, f_score)

      if current == goal
        return reconstruct_path(came_from, goal)
      end

      open_set -= [current]
      closed_set << current

      neighbours(current).each do |neighbour|
        next if closed_set.include?(neighbour)

        tentative = g_score[current] + distance_between(current, neighbour)

        if !open_set.include?(neighbour) || tentative < g_score[neighbour]
          came_from[neighbour] = current
          g_score[neighbour] = tentative
          f_score[neighbour] = g_score[neighbour] + estimate_distance(neighbour, goal)

          if !open_set.include?(neighbour)
            open_set << neighbour
          end
        end
      end
    end

    fail "Could not find a path"
  end

  def lowest_node(set, scores)
    set.min_by { |n| scores[n] }
  end

  def reconstruct_path(came_from, current_node)
    total_path = [current_node]

    while came_from.include?(current_node) do
      current_node = came_from[current_node]
      total_path << current_node
    end

    total_path
  end
end