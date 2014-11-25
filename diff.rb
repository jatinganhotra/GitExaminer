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
    @difffiles = []
    @num_difffiles = 0
    @stats = 0
    @prev_commit_sha = 0
    @next_commit_sha = 0
  end

  # So, that I can sort Diffs while calculating the diff for reverts
  def <=>(anOther)
    object_id <=> anOther.object_id
  end

  def initialize(prev_commit_sha, next_commit_sha, diff)
    # Input argument is diff obtained as:
    #     # diff = g.diff('7bd252aedfb842f3ad39facc439da43c6eaaf98f', '57a0e6030e06a6ee5893a3b9b0d75a351ad93691')
    @diff = diff
    @prev_commit_sha = prev_commit_sha
    @next_commit_sha = next_commit_sha
  end

  def generate_stats
    num_files = @stats[:total][:files]
    #puts "The files in @stats[:total] are - "
    #@stats[:files].each do |file_name, file_stats|
    #  puts file_name
    #end
    #puts " The size of @stats[:files] is = " + @stats[:files].size.to_s
    #puts "num_files are = " + num_files.to_s
    #puts "@num_difffiles = " + @num_difffiles.to_s
    raise "Num_files in stats != number of diffiles" unless num_files == @num_difffiles
  end

  def generate_difffiles_and_stats
    @difffiles = []
    # diff.class => Git::Diff
    # Get the stats for the diff, before extracting individual difffiles
    @stats = @diff.stats
    # Convert the Enumerable to Array
    diff = @diff.to_a

    @num_difffiles = diff.size
    @num_difffiles.times do |i|
      difffile = DiffFile.new( diff[i] )
      @difffiles << difffile
    end

    self.generate_stats
  end
end
