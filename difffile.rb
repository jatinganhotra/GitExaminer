require 'rubygems'
require 'logger'
require 'rugged'
require 'git'

load 'patch.rb'

class DiffFile

  attr_reader :patch, :file_name
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
      file_name_old_version = (@difffile.patch).match(/^[-]{3}.*/)
      file_name_new_version = (@difffile.patch).match(/^[+]{3}.*/)
      file_name_old_version = file_name_old_version.to_s.split("/").last
      file_name_new_version = file_name_new_version.to_s.split("/").last

      file_name_old_version = file_name_new_version if file_name_old_version = "null"
      # TODOD - FIXME : Only working for cases when you have the same file_name across the 2 revisions
      puts "file_name_new_version = " + file_name_new_version.to_s
      puts "file_name_old_version = " + file_name_old_version.to_s
      unless file_name_old_version == file_name_new_version
        raise "Both file names must be same"
      end

      # FIXME: Only setting the new file name when both are not equal
      @file_name = file_name_new_version
    end

    def generate_patch()
      patch_changes = @difffile.patch
      # puts "BEGIN &&&&&&&&&&&&&&&&&&&&&&&&&&&"
      # puts patch_changes
      # puts "END &&&&&&&&&&&&&&&&&&&&&&&&&&&"
      @patch = Patch.new(patch_changes)
      # Work on difffile to get patch
    end
end
