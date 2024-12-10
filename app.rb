# frozen_string_literal: true

require "json"

require "zeitwerk"
loader = Zeitwerk::Loader.new
loader.push_dir("lib")
loader.setup

BATCH_SIZE = 14_000

ProcessItems.new.call(ARGV[0] || "data/feed.xml", batch_size: BATCH_SIZE)
