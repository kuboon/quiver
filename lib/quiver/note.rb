module Quiver
  class Note
    attr_accessor :meta, :path, :notebook
    def initialize(content: , meta: , path: nil, notebook: nil)
      @content = content
      @meta = meta
      @path = Pathname.new(path) if path
      @notebook = notebook
      @adapter = notebook.root.adapter if notebook
    end
    def created_at
      Time.at(meta['created_at'])
    end
    def updated_at
      Time.at(meta['updated_at'])
    end
    def title
      @meta['title']
    end
    def uuid
      @meta['uuid']
    end
    def content
      @content ||= begin
        json, meta = @adapter.load(@path + 'content.json')
        JSON.parse(json)
      end
    end
    def cells
      content['cells'].map do |cell|
        case cell['type']
        when 'text';     Quiver::Cell::Text.new(cell, self)
        when 'markdown'; Quiver::Cell::Markdown.new(cell, self)
        else             Quiver::Cell.new(cell, self)
        end
      end
    end
    def to_html
      cells.map(&:to_html).join
    end
    def image_url(path)
      rel_path = path.gsub('quiver-image-url/', '')
      @adapter.image_url(@path + 'resources' + rel_path)
    end
    def save
      raise 'add to notebook first!' unless @path && @adapter
      adapter.mkpath(@path)
      adapter.save(@path + 'content.json', @content.to_json) if @content
      adapter.save(@path + 'meta.json', @meta.to_json)
    end
    def as_json(options = nil)
      return super if options
      {content: @content, meta: @meta, path: @path.to_s}
    end
  end
end
