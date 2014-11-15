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
      # Get the string from the MatchData returned by Regex.match
      @additions = (@changes).match(/^[\+][^+].*/).to_s
      @deletions = (@changes).match(/^[\-][^-].*/).to_s

      # TODO: This still looks buggy. Confirm.
      # Remove the first character +/- from the additions/ deletions string
      @additions[0] = ""
      @deletions[0] = ""

      # FIXME: This would be issued when you have a patch diff like -
      # Try to see how I handle such cases
      # diff --git a/django-docs/images/flatfiles_admin.png b/django-docs/images/flatfiles_admin.png
      # new file mode 100644
      # index 0000000..391a629
      # Binary files /dev/null and b/django-docs/images/flatfiles_admin.png differ
      # raise "Commit patch info READ FAILURE" unless @additions.to_s.size != 0 || @deletions.to_s.size != 0
      # puts "PATCH BREAKDOWN END"
    end
end
