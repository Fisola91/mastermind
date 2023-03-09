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

class Nonsense
  def initialize(a:, b:)
    @a = a
    @b = b
  end

  def something
    "default something"
  end
end

class App
  def do_stuff
    obj = Foo.new
    obj.method_a
  end

  def expensive_accounting_thing
    service = AccountingService.new
    service.process_payment
    service.refund_payment
    :ok
  end
end

class AccountingService
  def process_payment
    sleep 2
  end

  def refund_payment
    sleep 2
  end
end

RSpec.describe App do
  describe "#do_stuff" do
    it "can have a stubbed Foo#method_a value without using `allow_any_instance_of`" do
      fake_accounting_service = instance_double(AccountingService)
      expect(fake_accounting_service).to receive(:process_payment).and_return true
      expect(fake_accounting_service).to receive(:refund_payment).and_return true
      allow(AccountingService).to receive(:new).and_return(fake_accounting_service)

      expect(App.new.expensive_accounting_thing).to eq :ok
    end
  end
end

RSpec.describe Nonsense do
  describe "#something" do
    it "can be stubbed" do
      allow_any_instance_of(described_class).to receive(:something).and_return("stubbed something")

      object = Nonsense.new(a: "A", b: "B")
      expect(object.something).to eq "stubbed something"
    end
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
