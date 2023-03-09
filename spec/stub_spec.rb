class Foo
  SOME_CONSTANT = "default constant value"

  def self.method_b
    "default class method"
  end

  def method_a
    "default instance public"
  end

  private

  def something_private
    "default private"
  end
end

class App
  def do_stuff
    obj = Foo.new
    obj.method_a
  end
end

RSpec.describe Foo do
  describe ".method_b" do
    it "returns default value" do
      expect(described_class.method_b).to eq "default class method"
    end

    it "can be stubbed" do
      allow(described_class).to receive(:method_b).and_return "STUBBED"

      expect(described_class.method_b).to eq "STUBBED"
    end
  end

  describe "#method_a" do
    it "returns default value" do
      expect(described_class.new.method_a).to eq "default instance public"
    end

    it "can be stubbed directly" do
      object_1 = described_class.new
      allow(object_1).to receive(:method_a).and_return "STUBBED"

      expect(object_1.method_a).to eq "STUBBED"
    end

    it "can be stubbed indirectly" do
      allow_any_instance_of(described_class).to receive(:method_a).and_return "STUBBED"
      expect(App.new.do_stuff).to eq "STUBBED"
    end
  end

  describe "::SOME_CONSTANT" do
    it "returns default value" do
      expect(described_class::SOME_CONSTANT).to eq "default constant value"
    end

    it "can be stubbed" do
      stub_const("Foo::SOME_CONSTANT", "STUBBED")

      expect(described_class::SOME_CONSTANT).to eq "STUBBED"
    end
  end

  describe "#something_private" do
    it "doesn't really work" do
      expect { described_class.new.something_private }.to raise_error(NoMethodError)
    end
  end
end
