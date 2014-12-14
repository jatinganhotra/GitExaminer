require 'rubygems'
require 'logger'
require 'rugged'
require 'git'

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

      @additions[0] = ""
      @deletions[0] = ""

      # Assert commented for corner case, so that they are handled properly:
      # diff --git a/django-docs/images/flatfiles_admin.png b/django-docs/images/flatfiles_admin.png
      # new file mode 100644
      # index 0000000..391a629
      # Binary files /dev/null and b/django-docs/images/flatfiles_admin.png differ
      # raise "Commit patch info READ FAILURE" unless @additions.to_s.size != 0 || @deletions.to_s.size != 0
    end
end
