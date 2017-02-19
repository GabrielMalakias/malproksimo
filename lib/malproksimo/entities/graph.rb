class Graph
  attr_accessor :edges, :vertices

  def initialize(edges, vertices)
    @edges = edges
    @vertices = vertices
  end

  def has_source_and_destination_vertices?(source, destination)
    self.include?(source) && self.include?(destination)
  end

  def length_between(source, destination)
    @edges.each do |edge|
      return edge.length if edge.source == source and edge.destination == destination
    end
  end
end
