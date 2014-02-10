class AddWinnerToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :winner, :boolean, default: false
  end
end
