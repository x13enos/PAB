FactoryGirl.define do
  factory :creature do
    name "Creature"
    challenge_rating 1
    experience 1
    class_name "name"
    alignment "Нейтральный злой"
    size  5
    reach 5
    init  6
    sense "darkvision 60"
    perception 8
    race "human"
    type_name "Bard"
    subtypes ['first', 'second']
  end
end
