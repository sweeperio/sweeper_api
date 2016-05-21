describe SweeperAPI::Resource do
  let(:subject) { described_class.new(response) }

  shared_examples "a resource response" do
    it "parses meta values recursively" do
      expect(subject.meta.sweeper.version).to eq("0.1.0")
    end

    it "raises appropriately when method is not found" do
      expect { subject.type }.to raise_error(NoMethodError)
    end
  end

  context "when single entity returned" do
    let(:response) { JSON.parse(IO.binread("spec/fixtures/entity.json")) }

    it_behaves_like "a resource response"

    it "parses data" do
      expect(subject.data.id).to eq("L9qxZE6qJuBnSpJdAfw1MA2F")
      expect(subject.data.name).to eq("Demo Campaign 1")
      expect(subject.data.end_date).to be_nil
      expect(subject.data.fields[0].name).to eq("first_name")
      expect(subject.data.fields[1].options.less_than_or_equal_to).to eq(10)
    end

    it "exposes data methods on the root object" do
      expect(subject.id).to eq(subject.data.id)
      expect(subject.name).to eq(subject.data.name)
      expect(subject.start_date).to eq(subject.data.start_date)
      expect(subject.fields[0]).to eq(subject.data.fields[0])
    end

    it "can write to dynamic attributes" do
      subject.id                                      = "10"
      subject.fields[1].options.less_than_or_equal_to = 20

      expect(subject.id).to eq("10")
      expect(subject.fields[1].options.less_than_or_equal_to).to eq(20)
    end
  end

  context "when paged results returned" do
    let(:response) { JSON.parse(IO.binread("spec/fixtures/page.json")) }

    it_behaves_like "a resource response"

    it "makes resource quack like an array" do
      expect(subject.size).to eq(1)
      expect(subject[0].id).to eq("2")
      expect(subject[0].payload.first_name).to eq("John")
    end
  end
end
