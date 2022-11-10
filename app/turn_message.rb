class TurnMessage
  def self.for(result)
    if result == [:exact, :exact, :exact, :exact]
      "Congratulations!"
    elsif result == [:exact]
      "One color guessed at the exact position."
    elsif result == [:exact, :exact]
      "Two colors guessed at the exact position."
    elsif result == [:exact, :exact, :exact]
      "Three colors guessed at the exact position."
    elsif result == []
      "Incorrect guess."
    elsif result == [:partial, :partial, :partial, :partial]
      "Four colors guessed at the wrong position."
    elsif result == [:partial, :partial, :partial]
      "Three colors guessed at the wrong position."
    elsif result == [:partial, :partial]
      "Two colors guessed at the wrong position."
    elsif result == [:partial]
      "One color guessed at the wrong position."
    elsif result == [:exact, :partial]
      "Two colors guessed, one at the exact position and one at the wrong position."
    elsif result == [:exact, :exact, :partial]
      "Three colors guessed, two at the exact position and one at the wrong position."
    elsif result == [:exact, :partial, :partial]
      "Three colors guessed, one at the exact position and two at the wrong position."
    elsif result == [:exact, :partial, :partial, :partial]
      "Four colors guessed, one at the exact position and three at the wrong position."
    elsif result == [:exact, :exact, :exact, :partial]
      "Four colors guessed, three at the exact position and one at the wrong position."
    elsif result == [:exact, :exact, :partial, :partial]
      "Four colors guessed, two at the exact position and two at the wrong position."
    else
      "Result message not implemented: #{result.inspect}"
    end
  end
end
