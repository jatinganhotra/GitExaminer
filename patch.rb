require 'rubygems'
require 'logger'
require 'rugged'
require 'git'

class Patch

  attr_reader :additions
  attr_reader :deletions
    def initialize()
      @patch = nil
      @additions = nil
      @deletions = nil
    end

    def initialize(patch)
      @patch = patch
      self.patch_breakdown
    end

    def patch_breakdown()
      @additions = `grep '+' #{@patch}| grep -v '@@' | grep -v '+++'`
    end
end
