class Settings
  attr_accessor :teams, :countries, :picks

  def initialize
    @teams = []
    @countries = ["France", "Austria", "Turkey", "England", "Italy", "Russia", "Germany"]
    @picks = []
  end

  def set_teams
    ask_for_teams
    shuffle_teams
    should_we_shuffle
  end

  def pick_countries
    country = ""
    @teams.each do |team|
      invalid = true
      while invalid
        puts "#{team} : Pick a country"
        puts "These are the available countries: #{@countries}"
        country = pick_country
        if @countries.include?(country)
          add_to_picks(team, country)
          remove_picked_countries(country)
          invalid = false
          puts
        else
          puts "Not a valid country, try again."
          puts
        end
      end
    end
    return @picks
  end

  def ask_for_teams
    puts "Who are the 7 teams?"
    for i in 1..7
      print "--#{@teams}--"
      i = gets.chomp
      teams << i
    end
  end

  def should_we_shuffle
    puts
    print "--#{@teams}--"
    puts "Should we shuffle the order? Y/N"
    resp = gets.chomp

    while resp.downcase == 'y'
      @teams.shuffle!
      print "--#{@teams}--"
      puts "Should we shuffle the order? Y/N"
      resp = gets.chomp
    end

  end

  def shuffle_teams
    @teams.shuffle!
  end

  def pick_country
    country = ""
    country = gets.chomp
  end

  def add_to_picks(team, country)
    @picks << {team => country}
    @picks
  end

  def remove_picked_countries(country)
    countries.delete(country)
  end

end

class Diplomacy
  attr_accessor :settings

  def initialize
    @settings = Settings.new
  end

  def play!
    picks = []
    settings.set_teams
    settings.pick_countries
    puts "These are the picks:"
    settings.picks.each do |pick|
      pick.each do |team,country|
        puts "#{team} : #{country}"
      end
    end
  end

end

game = Diplomacy.new
game.play!
