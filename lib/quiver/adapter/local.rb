module Quiver
  module Adapter
    class Local
      def initialize(root)
        @root = Pathname.new(root)
      end
      def image_url(path)
        "file://" + path.to_s
      end
      def each(path, ext)
        @root.join(path).each_child(false) do |entry|
          next unless entry.to_s.end_with?(".#{ext}")
          yield entry
        end
      end
      def load(path)
        File.read @root.join(path)
      end
      def mkpath(path)
        @root.join(path).mkpath
      end
      def save(path, content)
        @root.join(path).write(content)
      end
    end
  end
end
