#!/usr/bin/env ruby

require 'time'
require 'bundler'
Bundler.require

jisyo_path = File.join(__dir__, 'SKK-JISYO.emoji.utf8')
license_path = File.join(__dir__, 'LICENSE')

File.open(jisyo_path, 'w') do |f|
  f << DATA.read.gsub(/%VERSION%/, Emot::VERSION)
  f << File.read(license_path).gsub(/^/, ";; ")
  f << ";;\n"
  f << ";; okuri-nasi entries.\n"

  list = Emot.list.map do |name, value|
    case name
    when :'8ball'
      name = :eight_ball
    when :'+1'
      name = :good
    when :'-1'
      name = :bad
    when :'-100'
      name = :hundred
    when :'-1234'
      name = :onetwo
    when /^[0-9+-]/
      p name
      raise name
    end
    [name, value]
  end
  list.sort.each do |name, (char, _code)|
    f << "#{name} /#{char}/\n"
  end
end

__END__
;; -*- fundamental -*- ; coding: utf-8 -*-
;; Emoji dictionary for SKK system
;;
;; Generated using emot %VERSION%
;;
