class AddPublicObfuscatorToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :public_obfuscator, :string
  end
end
