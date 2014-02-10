class DropWinnerIdFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :winner_id
  end
end
