def attack_most_often
  sql = <<-SQL
    SELECT attacker, COUNT(*) Total
    FROM
    (
      SELECT attacker_1 AS attacker
      FROM battles
      UNION ALL
      SELECT attacker_2
      FROM battles
      UNION ALL
      SELECT attacker_3
      FROM battles
      UNION ALL
      SELECT attacker_4
      FROM battles
    )
    WHERE attacker IS NOT NULL
    GROUP BY attacker
    ORDER BY Total DESC
    LIMIT 1
  SQL
  puts "Most common attacker:"
  puts DB[:conn].execute(sql)
end

def biggest_aggressive_loser
  sql = <<-SQL
    SELECT attacker, COUNT(*) Total
    FROM
    (
      SELECT attacker_outcome, attacker_1 AS attacker
      FROM battles
      UNION ALL
      SELECT attacker_outcome, attacker_2
      FROM battles
      UNION ALL
      SELECT attacker_outcome, attacker_3
      FROM battles
      UNION ALL
      SELECT attacker_outcome, attacker_4
      FROM battles
    )
    WHERE attacker IS NOT NULL
    AND attacker_outcome = 'loss'
    GROUP BY attacker
    ORDER BY Total DESC
    LIMIT 1
  SQL
  puts "Biggest aggressive loser:"
  puts DB[:conn].execute(sql)
end

def common_type_battle
  sql = <<-SQL
    SELECT battle_type
    FROM battles
    GROUP BY battle_type
    ORDER BY COUNT(battle_type) DESC
    LIMIT 1
  SQL
  puts "Most common battle type:"
  puts DB[:conn].execute(sql)
end

def common_battle_location
  sql = <<-SQL
    SELECT location
    FROM battles
    GROUP BY location
    ORDER BY COUNT(location) DESC
    LIMIT 2
  SQL
  puts "Most common battle locations:"
  puts DB[:conn].execute(sql)
end

def attacker_majority
  sql = <<-SQL
    SELECT name
    FROM battles
    WHERE attacker_outcome = 'loss'
    AND attacker_size > defender_size
    GROUP BY name
  SQL
  puts "Attackers lost battle while outnumbering defenders:"
  puts DB[:conn].execute(sql)
end
