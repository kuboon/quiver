module Quiver
  class Root
    attr_reader :adapter
    def initialize(adapter)
      @adapter = adapter
    end
    def each
      @each_cache = {}
      @adapter.each('.', 'qvnotebook') do |path|
        @each_cache[path] ||= begin
          meta = JSON.parse(@adapter.load(path + 'meta.json'))
          Notebook.new(meta: meta, path: path, root: self)
        end
        yield @each_cache[path]
      end
    end
    def notebook(name)
      each do |notebook|
        return notebook if notebook.name == name
      end
    end
    def add(notebook)
      raise 'this notebook already added' if notebook.path
      notebook.meta['uuid'] ||= SecureRandom.uuid.upcase
      notebook.path = @path + "#{notebook.meta['uuid']}.qvnotebook"
      notebook.adapter = @adapter
      notebook.save
    end
  end
end
