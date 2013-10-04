#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'rspec'

class Reducer
  def self.run
    `cat data/* | ruby lib/mapper.rb | sort | ruby lib/reducer.rb`
  end
end

describe Reducer do
  it 'should create cluster json from the words vector' do
    expected = ""
    result = Reducer.run
    array = result.split("\n")
    array.length.should eql 100
    i = 0
    array.each do |line|
      element = line.split("\t")
      element[0].to_i.should eql i
      element[1].include?("{").should be_true
      element[1].include?("}").should be_true
      i += 1
    end
  end
end
