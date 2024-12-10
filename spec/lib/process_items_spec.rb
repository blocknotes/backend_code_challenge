# frozen_string_literal: true

RSpec.describe "ProcessItems" do
  describe "#call" do
    subject(:call) { ProcessItems.new(max_batch_size: 400).call("some_file") }

    let(:file_content) do
      sample_file = File.expand_path("../fixtures/files/sample.xml", __dir__)
      File.read(sample_file)
    end
    let(:first_item) do
      [{ id: "9455173", title: "Lichtgroene gebreide cardigan",
         description: "<html>Een gebreide cardigan is een veel voorkomend stuk in een dameskleerkast. Dat is niet verrassend; het is zacht, warm, comfy en vooral heel modieus. Dit item van Elvira heeft een zachte kleur en bruine knopen. Het is een kort model met V-hals en elastisch biesje aan de mouwen.<br><br>Lengte ca. 50 cm bij maat S.</html>" }]
    end
    let(:second_item) do
      [{ id: "9455072", title: "Zwarte T-shirt met groene letters",
         description: "<html>Stay chic with me'. Dit zwart T-shirt van Elvira maakt jouw look compleet. Dit veelzijdig stuk kan je op heel wat manieren stylen om er helemaal jouw ding van te maken. Ga je voor een girly look met een rok of voor een sportief getinte outfit met een toffe jeans? Afgewerkt met zilveren bolletjes op de letters.<br><br>Lengte ca. 63 cm bij maat S.</html>" }]
    end
    let(:service) { instance_double(ExternalService, call: "Products: 123") }

    before do
      allow(File).to receive(:read).and_return(file_content)
      allow(ExternalService).to receive(:new).and_return(service)
    end

    it "calls the external service twice", :aggregate_failures do
      call

      expect(service).to have_received(:call).ordered.with(first_item.to_json)
      expect(service).to have_received(:call).ordered.with(second_item.to_json)
    end
  end
end
