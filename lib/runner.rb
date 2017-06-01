require 'fileutils'

class Runner
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def execute
    String.new.tap do |result|
      Dir.mktmpdir(nil, tmpdir) do |dir|
        path = File.join(dir, "run.rb")
        file = File.open(path, "w+") { |f| f.write(code) }
        command = %(docker run --rm -v #{dir}:/tmp ruby:latest ruby /tmp/run.rb)
        stdout  = `#{command}`
        status  = $?
        if status.success?
          result << stdout
        else
          result << "exit status #{status.to_i}"
        end
      end
    end
  end

  private

  def tmpdir
    File.expand_path("../../tmp", __FILE__)
  end

  class << self
    def execute(code)
      new(code).execute
    end
  end
end
