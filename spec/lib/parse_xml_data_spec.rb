# frozen_string_literal: true

RSpec.describe "ParseXmlData" do
  describe "#call" do
    subject(:call) { ParseXmlData.new.call(file_content) }

    let(:file_content) do
      sample_file = File.expand_path("../fixtures/files/sample.xml", __dir__)
      File.read(sample_file)
    end

    it "parses the input XML file and return an array of items" do
      expected_data = [
        {
          description: "<html>Een gebreide cardigan is een veel voorkomend stuk in een dameskleerkast. Dat is niet verrassend; het is zacht, warm, comfy en vooral heel modieus. Dit item van Elvira heeft een zachte kleur en bruine knopen. Het is een kort model met V-hals en elastisch biesje aan de mouwen.<br><br>Lengte ca. 50 cm bij maat S.</html>",
          id: "9455173",
          title: "Lichtgroene gebreide cardigan"
        },
        {
          description: "<html>Stay chic with me'. Dit zwart T-shirt van Elvira maakt jouw look compleet. Dit veelzijdig stuk kan je op heel wat manieren stylen om er helemaal jouw ding van te maken. Ga je voor een girly look met een rok of voor een sportief getinte outfit met een toffe jeans? Afgewerkt met zilveren bolletjes op de letters.<br><br>Lengte ca. 63 cm bij maat S.</html>",
          id: "9455072",
          title: "Zwarte T-shirt met groene letters"
        }
      ]
      expect(call).to eq expected_data
    end
  end
end
