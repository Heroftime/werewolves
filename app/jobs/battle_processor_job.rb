class BattleProcessorJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Pull all pending Battles
    battles = Battle.where(status: "Pending")

    if battles.count < 1
      puts "There are no battles to be processed"
    end

    battle_logs = []

    # Implement the Battle engine logic
    i = 0
    battles.each do |battle|
      # Get players data
      player1 = User.find(battle.initiator_id)
      player2 = User.find(battle.opponent_id)

      # Check if players have the gold to play, minimum: 20
      if player1.amount_of_gold < 20 or player2.amount_of_gold < 20
        msg = "One player doesn't have enough gold for a match"
        battle_logs << { battle_id: battle.id, log: msg }
        BattleLog.insert_all(battle_logs)
        return
      end

      # Don't start a battle if defender health is nil
      if player2.hit_points <= 0
        battle_logs << { battle_id: battle.id, log: "Defender #{player2.name} health is too low, battle cannot be started" }
        BattleLog.insert_all(battle_logs)
        return
      end

      play = {}
      play[player1.id] = player1
      play[player2.id] = player2

      percentage = 10

      attacker = play[player1.id]
      defender = play[player2.id]

      battle_logs << { battle_id: battle.id, log: "Battle has started!" }
      # Game Loop
      while true
        # Calculate damage
        attacker_hit_points = play[attacker.id]["hit_points"]
        attacker_attack_value = play[attacker.id]["attack_value"]

        # Defender Health
        defender_health = play[defender.id]["hit_points"]
        battle_logs << { battle_id: battle.id, log: "Defender #{defender.name} health is #{defender.hit_points}" }

        # Calculating damage and reduce attack value
        attacker_damage = (attacker_hit_points * percentage) / 100
        reduce_attack_value = (attacker_attack_value * percentage) / 100

        # Check Luck value here
        luck_checker = rand(0..100)
        if luck_checker > play[defender.id]["luck_value"]
          play[defender.id]["hit_points"] -= attacker_damage
          battle_logs << { battle_id: battle.id, log: "Attacker #{attacker.name} attacks defender #{defender.name}, Damage taken: #{attacker_damage}" }
        else
          battle_logs << { battle_id: battle.id, log: "Attacker #{attacker.name} attacks defender #{defender.name} but misses it" }
        end

        # Attack value can't be less than 50% of base value
        attacker_base_attack_value = User.find(attacker.id).attack_value
        attacker_min_attack_value = (attacker_base_attack_value * 50) / 100
        if play[attacker.id]["attack_value"] <= attacker_min_attack_value
          play[attacker.id]["attack_value"] = attacker_min_attack_value
        else
          play[attacker.id]["attack_value"] -= reduce_attack_value
        end

        battle_logs << { battle_id: battle.id, log: "Attacker #{attacker.name} attack value is at #{play[attacker.id]["attack_value"]}" }

        if play[defender.id]["hit_points"] <= 0
          battle_logs << { battle_id: battle.id, log: "Attacker #{attacker.name} won!" }

          # Gold logic
          defender_gold = play[defender.id]["amount_of_gold"]
          gold_percent_randomizer = rand(11..19)

          gold_stolen = (defender_gold * gold_percent_randomizer) / 100

          # Check if Defender has something to give
          if defender_gold > gold_stolen
            play[defender.id]["amount_of_gold"] -= gold_stolen
            play[attacker.id]["amount_of_gold"] += gold_stolen

            battle_logs << { battle_id: battle.id, log: "Attacker #{attacker.name} gets #{gold_stolen} gold from #{play[attacker.name]}" }

            # Preserve player's hard-earned gold only
            attacker = User.find(attacker.id)
            defender = User.find(defender.id)

            attacker.amount_of_gold = play[attacker.id]["amount_of_gold"]
            defender.amount_of_gold = play[defender.id]["amount_of_gold"]
            battle_logs << { battle_id: battle.id, log: "Gold is adjusted between two players" }

            # save them
            play[attacker.id].save!
            play[defender.id].save!
          else
            battle_logs << { battle_id: battle.id, log: "Defender #{defender.name} doesn't have any gold" }
          end

          # Set status to complete and assign winner
          battle.status = "Complete"
          battle.winner = attacker
          battle.save!

          battle_logs << { battle_id: battle.id, log: "Battle #{battle.id} has been processed successfully! Status set Complete and Winner assigned, congratulations!" }
          break
        end

        temp = play[attacker.id]
        attacker = play[defender.id]
        defender = temp
      end

      # Bulk insert all battle logs
      BattleLog.insert_all(battle_logs)
    end
  end
end
