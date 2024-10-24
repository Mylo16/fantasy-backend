class MyTeam < ApplicationRecord
  belongs_to :manager
  has_and_belongs_to_many :players

  # Max number of players in a team
  MAX_PLAYERS = 15

  # Method to add a player
  def add_player(player)
    if players.count < MAX_PLAYERS
      players << player
    else
      errors.add(:base, "Team already has #{MAX_PLAYERS} players")
    end
  end

  # Method to remove a player
  def remove_player(player)
    players.delete(player)
  end

  # Method to transfer a player (remove and add)
  def transfer_player(old_player, new_player)
    ActiveRecord::Base.transaction do
      remove_player(old_player)
      add_player(new_player)
    end
  rescue ActiveRecord::RecordInvalid
    errors.add(:base, "Transfer failed")
  end

  private

  # Validate position-specific rules
  def valid_position?(player)
    # Example: limit the number of forwards
    forward_count = players.where(position: 'Forward').count
    player.position != 'Forward' || forward_count < 3
  end

  # Ensure no more than 3 players from the same club
  def exceeding_club_limit?(player)
    players.where(club: player.club).count >= 3
  end
end
