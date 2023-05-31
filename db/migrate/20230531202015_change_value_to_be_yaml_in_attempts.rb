class ChangeValueToBeYamlInAttempts < ActiveRecord::Migration[7.0]
  def change
    change_column :attempts, :values, :text, default: [].to_yaml
  end
end
