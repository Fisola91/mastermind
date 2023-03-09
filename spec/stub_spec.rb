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

RSpec.describe "stubbing" do
end
