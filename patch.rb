require 'rubygems'
require 'logger'
require 'rugged'
require 'git'

# Using asserts - Approach #1
#require 'test/unit'
#extend Test::Unit::Assertions
#assert_not_equal( 1, 2)

# Writing own assert - Approach #2
#class AssertionError < RuntimeError
#end
#def assert &block
#    raise AssertionError unless yield
#end
#i = 1
#assert {i >= 0}
#assert { 5 == 12 }

class Patch

  attr_reader :additions
  attr_reader :deletions
  attr_reader :changes
    def initialize()
      @changes = nil
      @additions = nil
      @deletions = nil
    end

    def initialize(patch)
      @changes = patch
      self.patch_breakdown
    end

    def patch_breakdown()
      puts "PATCH BREAKDOWN"
      puts "The original patch is = \n"
      puts "Changes start - "
      puts @changes
      puts "Changes end - "
      #@additions = (@changes).match(/^[\+][^+][^+].*/)
      #@deletions = (@changes).match(/^[\-][^-][^-].*/)
      @additions = (@changes).match(/^[\+][^+].*/)
      @deletions = (@changes).match(/^[\-][^-].*/)
      puts "Additions are - " + @additions.to_s
      puts "Deletions are - " + @deletions.to_s
      puts "Size of additions = " + @additions.to_s.size.to_s
      puts "Size of deletions = " + @deletions.to_s.size.to_s
      raise "Commit patch info READ FAILURE" unless @additions.to_s.size != 0 || @deletions.to_s.size != 0
      puts "PATCH BREAKDOWN"
    end
end
