require "../app"

module CheckSum
  class App
    def print_help(io : IO)
      parser.help_message(io)
      io << "\n"
    end
  end
end
