class PersonSelection
  def initialize(people)
    @people = people
  end

  def select_person
    return nil if @people.empty?

    people_options = @people.map.with_index(1) do |person, index|
      "Number: #{index} - Role: #{person.class.name}, Name: #{person.name}, ID: #{person.id}"
    end
    puts people_options

    person_id_input = gets.chomp.to_i
    return nil if person_id_input < 1 || person_id_input > @people.size

    @people[person_id_input - 1]
  end
end
