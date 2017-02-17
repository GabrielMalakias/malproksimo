class EdgeRepository < Hanami::Repository
  def find_by_source_and_destination(source, destination)
    edges
      .where(source: source)
      .where(destination: destination)
  end
end
