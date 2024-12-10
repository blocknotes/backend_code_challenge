# frozen_string_literal: true

require "ox"

class ParseXmlData
  XML_ITEM_PATH = "rss/channel/item"

  def call(xml_data)
    doc = Ox.parse(xml_data)
    doc.locate(XML_ITEM_PATH).map do |item|
      attrs = extract_item_attributes(item)
      {
        id: attrs["g:id"],
        title: attrs["title"],
        description: attrs["description"]
      }
    end
  end

  private

  def extract_item_attributes(item)
    item.nodes.to_a.to_h { [_1.value, _1.text] }
  end
end
