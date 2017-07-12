class Execution

  def initialize

    self.character_deaths
    self.battle
    self.character_predictions
    self.menu
  end

  def menu
    run = 1
    system "clear"
    self.display_options
    while run == 1
      menu_option = gets.chomp
      case menu_option
      when "1"
        attack_most_often
      when "2"
        biggest_aggressive_loser
      when "3"
        common_type_battle
      when "4"
        common_battle_location
      when "5"
        attacker_majority
      when "6"
        run = 0
      end
    end
  end

  def display_options
    puts "Welcome to Game of Thrones Knowledge Base:
    1. Most common attacker
    2. Biggest aggressive loser
    3. Most common battle type
    4. Most common battle locations
    5. Attackers lost battle while outnumbering defenders
    6. Exit"
  end

  def character_deaths
    death = Game_Of_Thrones.new("./character_deaths.csv")
    death.get_columns
    death.get_datatypes
    death.attributes
    death.create_table
    death.insert
  end

  def battle
    battles = Game_Of_Thrones.new("./battles.csv")
    battles.get_columns
    battles.get_datatypes
    battles.attributes
    battles.create_table
    battles.insert
  end

  def character_predictions
    prediction = Game_Of_Thrones.new("./character_predictions.csv")
    prediction.get_columns
    prediction.get_datatypes
    prediction.attributes
    prediction.create_table
    prediction.insert
  end

end
