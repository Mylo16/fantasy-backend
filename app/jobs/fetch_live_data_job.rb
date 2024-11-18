class FetchLiveDataJob < ApplicationJob
  queue_as :default

  BASE_URL = 'https://fantasy.premierleague.com/api/v1/gameweeks/'

  def perform
    gameweek_id = current_gameweek_id
    return unless gameweek_id

    gameweek = Gameweek.find(gameweek_id)
    return unless gameweek.started == true
    response = fetch_live_data(gameweek_id)
    process_data(response) if response
  end

  private

  def current_gameweek_id
    current_date = Time.zone.now
    gameweek = Gameweek.find_by("start_date <= ? AND end_date >= ?", current_date, current_date)
    gameweek&.id
  end
  
  def fetch_live_data(gameweek_id)
    url = "#{BASE_URL}#{gameweek_id}/live/"
    response = HTTParty.get(url) # Ensure `httparty` gem is added to your Gemfile
    response.success? ? JSON.parse(response.body) : nil
  end

  def process_data(data)
    gameweek = Gameweek.find_by(id: data['id'])
    return unless gameweek

    data['players'].each do |player|
      player_id = player['id']
      player_stats = player['stats']
      points_breakdown = player['explain']

      update_player(player_id, player_stats)
      update_fixtures(gameweek, player_id, points_breakdown)
    end
    gameweek.update(status: "in progress")
  end

  def update_player(player_id, stats)
    player = Player.find_by(id: player_id)
    return unless player

    player.update(
      goals: stats['goals_scored'],
      assists: stats['assists'],
      clean_sheets: stats['clean_sheets'],
      yellow_cards: stats['yellow_cards'],
      red_cards: stats['red_cards']
    )
  end

  def update_fixtures(gameweek, player_id, points_breakdown)
    points_breakdown.each do |match|
      fixture = gameweek.fixtures.find_by(id: match['fixture'])
      next unless fixture

      team = Team.find_by(player_id: player_id)
      match['stats'].each do |stat|
        if stat['identifier'] == 'goals_scored'
          if team.id == fixture.team_h
            fixture.home_team_score ||= 0
            fixture.home_team_score += stat['value']
          elsif team.id == fixture.team_a
            fixture.away_team_score ||= 0
            fixture.away_team_score += stat['value']
          end
        end
        update_fixture_stat(fixture, stat, player_id, team)
      end
      fixture.save
    end
  end

  def update_fixture_stat(fixture, stat, player_id, team)
    identifier = stat["identifier"]
    value = stat["value"]
    points = stat["points"]

    existing_stat = fixture.stats.find_by(identifier: identifier)
    
    if existing_stat
      update_existing_stat(existing_stat, player_id, value, points, fixture, team)
    else
      create_new_stat(fixture, identifier, player_id, value, points, team)
    end
  end

  def update_existing_stat(existing_stat, player_id, value, points, fixture, team)
    if team.id == fixture.team_h
      existing_stat.home_stats.find { |s| s["player"] == player_id }&.update("value" => value, "points" => points)
    else
      existing_stat.away_stats.find { |s| s["player"] == player_id }&.update("value" => value, "points" => points)
    end
  end

  def create_new_stat(fixture, identifier, player_id, value, points, team)
    if team.id == fixture.team_h
      fixture.stats.create(identifier: identifier, home_stats: [{ value: value, player: player_id, points: points }], away_stats: [])
    else
      fixture.stats.create(identifier: identifier, home_stats: [], away_stats: [{ value: value, player: player_id, points: points }])
    end
  end
end
