#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'json'

class Mapper
  def map(stdin)
    stdin.each_line {|line|
      key, tag, json = line.force_encoding("utf-8").strip.split("\t")
      hash = JSON.parse(json)
      i = 0
      new_hash = {}
      hash = hash.each do |k,v|
        if i < 30
          unless k == "http" or k == "htn" or k == "twitt"
            new_hash[k] = v
          end
        end
        i += 1
      end
      mapper_output(key, tag, new_hash)
    }
  end

  private

  def mapper_output(key, tag, hash)
    puts "#{key}\t#{tag}\t#{JSON.generate(hash)}"
  end
end

if __FILE__ == $0
  mapper = Mapper.new
  mapper.map($stdin)
end

