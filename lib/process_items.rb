# frozen_string_literal: true

require "json"

class ProcessItems
  attr_reader :max_batch_size

  def initialize(max_batch_size: 5 * 1_024 * 1_024)
    @service = ExternalService.new
    @max_batch_size = max_batch_size
  end

  def call(file)
    xml_data = File.read(file)
    list = ParseXmlData.new.call(xml_data)
    json_data = list.map(&:to_json)
    process_list(json_data)
  end

  private

  attr_reader :service

  def process_list(list)
    size = 1
    batch = []

    loop do
      item = list.shift
      break unless item

      item_size = item.bytesize + 1
      if (size + item_size) < max_batch_size
        batch << item
      else
        process_batch(batch)
        batch = [item]
        size = 1
      end

      size += item_size
    end

    process_batch(batch) if batch.any?
  end

  def process_batch(batch)
    payload = "[#{batch.join(',')}]"
    service.call(payload)
  rescue StandardError => e
    puts "Batch processing failed: #{e}"
  end
end
