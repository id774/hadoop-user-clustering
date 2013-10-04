#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'json'
require 'kmeans/pair'
require 'kmeans/pearson'
require 'kmeans/cluster'

class Reducer
  def reduce(stdin)
    user_hash = {}

    stdin.each_line {|line|
      key, tag, json = line.force_encoding("utf-8").strip.split("\t")
      hash = JSON.parse(json)
      user_hash[key] = hash
    }

    result = Kmeans::Cluster.new(user_hash, {
      :centroids => 100,
      :loop_max => 10
    })

    result.make_cluster

    i = 0
    result.cluster.values.each {|array|
      hash = {}
      array.each {|word|
        hash[word] = 1
      }
      reducer_output(i, JSON.generate(hash))
      i += 1
    }
  end

  private

  def reducer_output(key, hash)
    puts "#{key}\t#{hash}"
  end
end

if __FILE__ == $0
  reducer = Reducer.new
  reducer.reduce($stdin)
end
