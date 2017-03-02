class AddDefenceFieldsToCreature < ActiveRecord::Migration[5.0]
  def change
    add_column :creatures, :armor_class, :integer
    add_column :creatures, :armor_class_touch, :integer
    add_column :creatures, :armor_class_flat_footed, :integer
    add_column :creatures, :armor_class_description, :string
    add_column :creatures, :hit_points, :integer
    add_column :creatures, :hit_dice, :string
    add_column :creatures, :regeneration, :string
    add_column :creatures, :fortitude, :integer
    add_column :creatures, :reflex, :integer
    add_column :creatures, :will, :string
    add_column :creatures, :defensive_abilities, :string
    add_column :creatures, :damage_reduction, :string
    add_column :creatures, :immune, :string
    add_column :creatures, :resist, :string
    add_column :creatures, :spell_resistance, :string
  end
end
