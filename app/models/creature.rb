class Creature < ApplicationRecord
  LIST_OF_CREATURES = ["goblin", "ghoul", "horse", "spider swarm"]

  SIZE_TABLE = { "Fine" => 0.5, "Diminutive" => 1, "Tiny" => 2, "Small" => 5, "Medium" => 5,
                 "Large" => 10, "Huge" => 15, "Gargantuan" => 20, "Colossal" => 30 }
  REACH_TABLE = { "Fine" => 0, "Diminutive" => 0, "Tiny" => 0, "Small" => 5, "Medium" => 5,
                 "Large" => 10, "Huge" => 15, "Gargantuan" => 20, "Colossal" => 30 }

  paginates_per 20
end
