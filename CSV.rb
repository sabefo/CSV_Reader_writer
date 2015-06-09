require "csv"
require 'faker'

class Person

	attr_accessor :email, :phone
	attr_reader :first_name, :last_name, :created_at

	def initialize(first_name, last_name, email, phone)
		@first_name = first_name
		@last_name = last_name
		@email = email
		@phone = phone
		@created_at = Time.new
	end

	def people(number)
		people = []
		for i in 0...number
			persona = Person.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number)
			people << persona
		end
		people
	end
end

class PersonWriter

	def initialize(name, array)
		@name = name
		@array = array
	end

	def create_csv

		CSV.open(@name,"w") do |csv|
			@array.each {|person|
				csv << [person.first_name, person.last_name, person.email, person.phone, Time.now]
			}
		end	
	end

end

class PersonParser
	def initialize(file)
		@file = file
	end

	def people
		personas = []
		CSV.foreach(@file) do |col|
    # Where col corresponds to a zero-based value/column in the csv
	    personas << [col[0] + "\t" + col[1] + "\t" + col[2] + "\t" + col[3] + "\t" + col[4]]
		end
#		puts @people
		puts personas
	end

end

persona = Person.new("Sandra", "Tirado", "sandra@tirado.com", 5565413249)
person = persona.people(1000)

person_writer = PersonWriter.new("people.csv", person)
person_writer.create_csv

parser = PersonParser.new("people.csv")
people = parser.people









