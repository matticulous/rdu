#!/usr/bin/env ruby

require 'optparse'
require 'find'
require 'json'

options = {}
# Parse program flags and switches
op = OptionParser.new do |opts|
  # Directory to scan
  opts.on("-d DIR", "Directory containing files to list") do |dir|
    options[:dir] = dir
  end
  # Print output as a condensed JSON string, useable by consuming programs
  opts.on("-u", "--ugly", "Print output as JSON string") do
    options[:ugly] = true
  end
end
op.parse!

# A directory to scan must be provided
if !options[:dir]
  STDERR.puts "Error: you must supply a directory"
  puts op.help
  exit(1)
end

file_hash = { :files => [] }
begin
  # Build a hash of files keyed by path with a value of size in bytes
  Find.find(options[:dir]) do |path|
    if !FileTest.directory?(path) && FileTest.exist?(path)
      file_hash[:files] << { :path => path, :size => FileTest.size(path)}
    end
  end
  # Print the files hash to JSON
  if options[:ugly]
    puts JSON.generate(file_hash)
  else
    puts JSON.pretty_generate(file_hash)
  end
rescue Exception => e
  puts e.message
end
