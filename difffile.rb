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
      # Tip : Only picking the last part seems reasonable
      # unless there are same files in different directories
      file_name_old_version = file_name_old_version.to_s.split("/").last
      file_name_new_version = file_name_new_version.to_s.split("/").last

      # The file names would be /dev/null when the file is added/ deleted
      file_name_old_version = file_name_new_version if file_name_old_version == "null"
      file_name_new_version = file_name_old_version if file_name_new_version == "null"
      raise "Both file names must be same" if file_name_old_version != file_name_new_version

      @file_name = file_name_new_version
    end

    def generate_patch()
      patch_changes = @difffile.patch
      @patch = Patch.new(patch_changes)
    end
end