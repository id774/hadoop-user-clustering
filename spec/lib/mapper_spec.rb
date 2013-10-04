#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'rspec'
require 'json'

class Mapper
  def self.run
    `cat data/* | ruby lib/mapper.rb | grep "zekitter"`
  end
end

describe Mapper do
  it 'should output the top 30 words vector from tweets' do
    expected = "zekitter\t93639986\t{\"人\":227,\"俺\":101,\"留年\":61,\"Twitter\":61,\"京大\":58,\"生\":54,\"的\":52,\"者\":51,\"日\":48,\"社会\":47,\"方\":47,\"zekitter\":42,\"神\":40,\"時\":38,\"時間\":38,\"何\":36,\"大学\":36,\"気\":35,\"男\":35,\"内定\":34,\"女の子\":33,\"女子\":33,\"会\":31,\"Facebook\":31,\"自分\":31,\"女性\":28,\"完全\":27,\"年\":26,\"学生\":25}\n"
    result = Mapper.run
    result.should eql expected
  end
end
