class CreateTraps < ActiveRecord::Migration[5.0]
  def change
    create_table :traps do |t|
      t.string :name
      t.integer :challenge_rating
      t.integer :experience
      t.string :type_of_system
      t.string :reset
      t.string :trigger
      t.text :effect
      t.text :description
      t.integer :perception
      t.integer :disable_devise

      t.timestamps
    end
  end
end
