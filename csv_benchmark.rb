#!/usr/bin/env ruby

require 'benchmark'

require 'csv'
require 'ccsv'
require 'csvreader'
require 'fastcsv'
require 'fasterer_csv'
require 'fastest-csv'
require 'rcsv'
require 'smarter_csv'
require 'tabular'

CSV_PATH = File.expand_path('example.csv').freeze
ITERATIONS = 120

Benchmark.bmbm do |benchmark|

  benchmark.report('csv (stdlib)') do
    ITERATIONS.times do
      CSV.foreach(CSV_PATH) do |_line|
        # print '='
      end
    end
  end

  # https://github.com/evan/ccsv
  benchmark.report('ccsv') do
    ITERATIONS.times do
      Ccsv.foreach(CSV_PATH) do |_line|
        # print '.'
      end
    end
  end

  # # https://github.com/csvreader/csvreader#usage
  # benchmark.report('csvreader') do
  #   ITERATIONS.times do
  #     CsvReader.foreach(CSV_PATH) do |_line|
  #       # print '+'
  #     end
  #   end
  # end

  # https://github.com/jpmckinney/fastcsv#usage
  benchmark.report('fastcsv') do
    ITERATIONS.times do
      begin
        file = File.open(CSV_PATH)
        result = FastCSV.raw_parse(file) do |_line|
          # print '^'
        end
      ensure
        file.close
      end
    end
  end

  # https://github.com/gnovos/fasterer-csv
  benchmark.report('fasterer-csv') do
    ITERATIONS.times do
      FastererCSV.read(CSV_PATH) do |_line|
        # print '#'
      end
    end
  end

  # https://github.com/brightcode/fastest-csv#usage
  benchmark.report('fastest-csv') do
    ITERATIONS.times do
      FastestCSV.foreach(CSV_PATH) do |_line|
        # print '-'
      end
    end
  end

  # https://github.com/fiksu/rcsv#usage
  benchmark.report('rcsv') do
    ITERATIONS.times do
      begin
        file = File.open(CSV_PATH)
        Rcsv.parse(file) do |_line|
          # print '+'
        end
      ensure
        file.close
      end
    end
  end

  # https://github.com/tilo/smarter_csv/wiki/The-Basics#another-vanilla-csv-file
  benchmark.report('smarter_csv') do
    ITERATIONS.times do
      SmarterCSV.process(CSV_PATH) do |_line|
        # print '!'
      end
    end
  end

  # https://github.com/scottwillson/tabular
  benchmark.report('tabular') do
    ITERATIONS.times do
      Tabular::Table.read(CSV_PATH).rows.each do |_line|
        # print '?'
      end
    end
  end

end
