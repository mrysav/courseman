#!/usr/bin/env ruby

require 'csv'

file = CSV.read("courses.csv")

system("mkdir syllabi")

file.each do |row|
    if (row[15])
#        print row[2] + ': ' + row[5] + "\n"
        system("wget -O syllabi/" + row[15] + " https://peak.d.umn.edu/ieo/upload/" + row[15])
    end
end
