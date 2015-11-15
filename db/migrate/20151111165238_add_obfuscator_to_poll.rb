class AddObfuscatorToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :obfuscator, :string
  end
end
