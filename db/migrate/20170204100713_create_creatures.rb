class CreateCreatures < ActiveRecord::Migration[5.0]
  def change
    create_table :creatures do |t|
      t.string      :name
      t.boolean     :active
      t.float       :challenge_rating
      t.integer     :experience
      t.string      :class_name
      t.string      :alignment
      t.integer     :size
      t.integer     :reach
      t.integer     :init
      t.string      :sense
      t.integer     :perception
      t.string      :race
      t.string      :type_name
      t.text        :subtypes, :array => true, :default => []

      t.timestamps
    end
  end
end
