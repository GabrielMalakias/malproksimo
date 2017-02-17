class Graph < Array
  attr_accessor :edges

  def initialize
    @edges = []
  end

  def push_edge(edge)
    @edges.push(edge)
  end

  def has_source_and_destination_vertices?(source, destination)
    self.include?(source) && self.include?(destination)
  end

  def neighbors(vertex)
    n = []

    @edges.each do |edge|
      n.push(edge.destination) if edge.source == vertex
    end

    n.uniq
  end

  def length_between(source, destination)
    @edges.each do |edge|
      return edge.length if edge.source == source and edge.destination == destination
    end
    nil
  end
end

