require_relative "../app/mini_max"

RSpec.describe MiniMax do
  let(:passcode) {
    %w(RED RED GREEN GREEN)
  }
  let(:colors) {
    %w(RED ORANGE YELLOW GREEN BLUE PURPLE)
  }

  describe "#play" do
    passcodes = [
      %w(RED RED RED RED),
      %w(RED RED RED GREEN),
      %w(RED RED GREEN GREEN),
      %w(RED GREEN GREEN GREEN),
      %w(GREEN GREEN GREEN GREEN),
    ]
    passcodes.each do |passcode|
      it "guesses #{passcode.join(' ')} correctly" do
        instance = described_class.new(passcode: passcode, combinator: colors)
        instance.play
        expect(instance.guess_array.length).to be <= 5
        expect(instance.guess_array.last).to eq passcode
      end
    end
  end
end
