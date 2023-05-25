require 'json'
class FileHandler
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

  def read_from_file
    return nil unless File.exist?(@path)

    file = File.open(@path, 'r')
    data = file.read
    file.close

    data
  end
end
