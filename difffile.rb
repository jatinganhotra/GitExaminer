require 'rubygems'
require 'logger'
require 'rugged'
require 'git'

class DiffFile

  attr_reader :patch
    def initialize()
      @difffile = nil
      @patch = nil
    end

    def initialize(difffile)
      @difffile = difffile
    end

    def generate_patch()
      @patch = @difffile.patch
      # Work on difffile to get patch
    end
end
