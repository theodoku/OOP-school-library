require 'json'
class File_Handler
    attr_accessor :path, :store
    def initialize(path)
        @path = path
    end

    def write_to_file(data)
        file = File.open(@path, 'w')
        # @store << data
        file.write(data)
        file.close
    end
end
