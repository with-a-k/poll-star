class AddPublicFlagToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :public, :boolean
  end
end
