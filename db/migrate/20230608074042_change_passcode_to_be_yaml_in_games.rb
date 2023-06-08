class ChangePasscodeToBeYamlInGames < ActiveRecord::Migration[7.0]
  def change
    change_column :games, :passcode, :text, default: [].to_yaml
  end
end
