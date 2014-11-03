require 'rubygems'
require 'logger'
require 'rugged'
require 'git'

load 'patch.rb'

class DiffFile

  attr_reader :patch
    def initialize()
      @difffile = nil
      @patch = nil
      @stats = nil
      @file_name = nil
    end

    def initialize(difffile)
      @difffile = difffile
      self.generate_patch
      self.set_file_name
    end

    def set_file_name

    end

    def generate_patch()
      patch_changes = @difffile.patch
      @patch = Patch.new(patch_changes)
      # Work on difffile to get patch
    end
end
