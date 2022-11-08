require "./app/web_ui"

RSpec.describe WebUI do
  describe "#guess_attempts" do
    it "allows player to make 10 attempts" do
      expect(subject.guess_attempts).to eq(10)
    end
  end

  describe "#code_length" do
    it "returns code lenght as 4" do
      expect(subject.code_length).to eq(4)
    end
  end

  describe "#colors" do
    it "returns array of colors" do
      expect(subject.colors).to match_array(%w(red orange yellow green blue purple))
    end
  end
end
