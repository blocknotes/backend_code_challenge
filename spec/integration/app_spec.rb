# frozen_string_literal: true

RSpec.describe "App" do
  describe "#call" do
    subject(:call) { ProcessItems.new.call(file, batch_size: 1_000) }

    let(:file) { File.expand_path("../fixtures/files/sample.xml", __dir__) }

    it "processes the sample file" do
      expect { call }.to output(/Received batch\s+1.+Size:\s+0.00MB.+Products:\s+2/m).to_stdout
    end
  end
end
