require_relative "../app/mini_max"

RSpec.describe MiniMax do
  let(:passcode) {
    %w(RED RED GREEN GREEN)
  }
  let(:colors) {
    %w(RED GREEN BLUE)
  }

  describe "#initialize" do
    passcodes = [
      %w(RED RED RED RED),
      %w(RED RED RED GREEN),
      %w(RED RED GREEN GREEN),
      %w(RED GREEN GREEN GREEN),
      %w(GREEN GREEN GREEN GREEN),
    ]
    passcodes.each do |passcode|
      it "guesses #{passcode.join(' ')} correctly" do
        instance = described_class.new(passcode: passcode, colors: colors)
        expect(instance.play).to eq passcode
      end
    end
  end
end
