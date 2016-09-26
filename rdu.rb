#!/usr/bin/env ruby

require 'optparse'
require 'find'
require 'json'

options = {}
#default directory location of home dir?
op = OptionParser.new do |opts|
  opts.on("-d DIR", "Directory containing files to list") do |dir|
    options[:dir] = dir
  end
  opts.on("-u", "--ugly", "Print output as JSON string") do
    options[:ugly] = true
  end
end
op.parse!

if options.empty?
  STDERR.puts "Error: you must supply a directory"
  puts op.help
  exit(1)
end

file_hash = { :files => [] }
Find.find(options[:dir]) do |path|
  if !FileTest.directory?(path)
    file_hash[:files] << { path => FileTest.size(path)}
  end
end

if options[:ugly]
  puts JSON.generate(file_hash)
else
  puts JSON.pretty_generate(file_hash)
end
