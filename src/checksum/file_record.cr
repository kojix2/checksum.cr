module CheckSum
  # Define a FileRecord structure to store the checksum and file path
  struct FileRecord
    property checksum : String
    property filepath : Path

    def initialize(@checksum, @filepath)
    end

    # Returns the algorithm used to calculate the checksum based on the checksum pattern
    def guess_algorithm : Algorithm
      case checksum
      when /^[0-9a-f]{32}$/  then Algorithm::MD5
      when /^[0-9a-f]{40}$/  then Algorithm::SHA1
      when /^[0-9a-f]{64}$/  then Algorithm::SHA256
      when /^[0-9a-f]{128}$/ then Algorithm::SHA512
      else
        raise UnknownAlgorithmError.new("Unknown algorithm for checksum: #{checksum}")
      end
    end

    # Return the string representation of the FileRecord
    # If the file path is "-", return only the checksum (for standard input)
    def to_s
      return checksum if filepath == Path["-"]
      "#{checksum}  #{filepath}"
    end
  end
end
