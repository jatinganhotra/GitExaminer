load 'difffile.rb'

class Diff

  attr_reader :diff
  attr_reader :difffiles
  attr_reader :num_difffiles
  attr_reader :stats
  attr_reader :prev_commit_sha
  attr_reader :next_commit_sha
  
  def initialize()
    @diff = nil
    @difffiles = Array.new
    @num_difffiles = 0
    @stats = 0
    @prev_commit_sha = 0
    @next_commit_sha = 0
  end

  def initialize(prev_commit_sha, next_commit_sha, diff)
    # Input argument is diff obtained as:
    #     # diff = g.diff('7bd252aedfb842f3ad39facc439da43c6eaaf98f', '57a0e6030e06a6ee5893a3b9b0d75a351ad93691')
    @diff = diff
    @prev_commit_sha = prev_commit_sha
    @next_commit_sha = next_commit_sha
  end

  def generate_difffiles_and_stats

    # Initialize @diffiles to empty array
    # FIXME: This has been already done in initialize, so this shouldn't go here again
    @difffiles = []
    # diff.class => Git::Diff
    # Get the stats for the diff, before extracting individual difffiles
    @stats = @diff.stats
    # Convert the Enumerable to Array
    diff = @diff.to_a
    # diff.class => Array

    @num_difffiles = diff.size
    @num_difffiles.times do |i|
      difffile = DiffFile.new( diff[i] )
      difffile.generate_patch
      @difffiles << difffile
    end
  end
end
