module Quiver
  class Cell
    def initialize(json, note)
      @note = note
      @data = json['data']
    end

    class Text < Cell
      def to_html
        "<pre>#{@data}</pre>"
      end
    end
    class Markdown < Cell
      def initialize(note, json)
        super
        @data.gsub!(%r|quiver-image-url/([^)]+)|) do |path|
          @note.image_url(path)
        end
      end
      def to_html
        Quiver.config.markdown_renderer.call(@data)
      end
    end
  end
end
