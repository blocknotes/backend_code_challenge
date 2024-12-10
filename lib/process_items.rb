# frozen_string_literal: true

require "json"

class ProcessItems
  def call(file, batch_size:)
    xml_data = File.read(file)
    list = ParseXmlData.new.call(xml_data)
    service = ExternalService.new
    list.each_slice(batch_size) do |batch|
      service.call(batch.to_json)
    end
  end
end
