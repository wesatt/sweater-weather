# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ApiKey.destroy_all
User.destroy_all

user = User.create!(id: 1, email: 'yogi@picnics.gov', password: 'noturaveragebear', password_confirmation: 'noturaveragebear')
# user.api_keys.create!(token: SecureRandom.hex)
user.api_keys.create!(id: 1, token: "35f291ad58d0ac2c5a6275cbe56eb4d3")

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('api_keys')
