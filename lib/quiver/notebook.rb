module Quiver
  class Notebook
    attr_reader :meta, :path, :root
    def initialize(meta:, path: nil, root: nil)
      @meta = meta
      @path = Pathname.new(path) if path
      @root = root
      @adapter = root.adapter if root
    end
    def name
      @meta['name']
    end
    def each(include_content: false)
      raise 'This notebook has no root' unless @adapter
      @adapter.each(@path, 'qvnote') do |path|
        content = JSON.parse(@adapter.load(@path + path + 'content.json')) if include_content
        meta    = JSON.parse(@adapter.load(@path + path + 'meta.json'))
        yield Note.new(content: content, meta: meta, path: @path + path, notebook: self)
      end
    end
    def save
      raise 'add to root first!' unless @path && @adapter
      adapter.mkpath(@path)
      adapter.save(@path + 'meta.json', @meta.to_json)
    end
    def add(note)
      raise 'this note already added' if note.path
      note.meta['uuid'] ||= SecureRandom.uuid.upcase
      note.path = @path + "#{note.meta['uuid']}.qvnote"
      note.adapter = @adapter
      note.save
    end
  end
end
