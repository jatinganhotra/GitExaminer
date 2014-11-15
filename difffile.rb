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

    # e.g. diff_file_name is "--- a/chapters/10-pagination.md"
    def extract_file_name(diff_file_name)
      file_name = diff_file_name.to_s.split("/")
      # Remove the first part of "--- a"
      file_name.shift
      # Re-join the remaining parts
      file_name = file_name.join('/')
      return file_name
    end

    def set_file_name
      file_name_old_version = (@difffile.patch).match(/^[-]{3}.*/)
      file_name_new_version = (@difffile.patch).match(/^[+]{3}.*/)
      file_name_old_version = extract_file_name(file_name_old_version)
      file_name_new_version = extract_file_name(file_name_new_version)

      # The file names would be /dev/null when the file is added/ deleted
      file_name_old_version = file_name_new_version if file_name_old_version == "dev/null"
      file_name_new_version = file_name_old_version if file_name_new_version == "dev/null"
      raise "Both file names must be same" if file_name_old_version != file_name_new_version

      @file_name = file_name_new_version
    end

    def generate_patch()
      patch_changes = @difffile.patch
      @patch = Patch.new(patch_changes)
    end
end