require "colorize"

require "./parser"
require "./option"
require "./file_record"
require "./digest"
require "./redirect"

require "./app/*"
require "../ioctl"

module CheckSum
  class App
    include Redirect

    getter parser : Parser
    getter option : Option

    EXIT_SUCCESS = 0
    EXIT_FAILURE = 1

    def initialize
      @option = Option.new
      @parser = Parser.new(@option)
    end

    def run
      @option = parser.parse(ARGV)
      exit case option.action
      when Action::Compute
        Computer.new(option).run
      when Action::Check
        Checker.new(option).run
      when Action::Version
        print_version
      when Action::Help
        print_help
      else
        print_help
      end
    rescue ex
      stderr.puts "[checksum] ERROR: #{ex.class} #{ex.message}".colorize(:red).bold
      stderr.puts "\n#{ex.backtrace.join("\n")}" if CheckSumError.debug?
      exit(1)
    end
  end
end
