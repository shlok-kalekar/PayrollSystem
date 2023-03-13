# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Role.create!('role_type' => 'Administrator')
Role.create!('role_type' => 'Employee')

User.create!('full_name' => 'Shlok Kalekar',
             'gender_type' => 'Male',
             'phone_no' => '9876543210',
             'designation_type' => 'Admin Manager',
             'city_name' => 'Pune',
             'join_date' => '2022-01-16',
             'tot_paid_leaves' => 8,
             'email' => 'shlok@josh.com',
             'password' => '123456',
             'role_id' => 1)

User.create!([{
               'full_name' => 'Radha Sharma',
               'gender_type' => 'Female',
               'phone_no' => '8173801728',
               'designation_type' => 'HR Head',
               'city_name' => 'Bangalore',
               'join_date' => '2022-08-16',
               'tot_paid_leaves' => 10,
               'email' => 'radha@josh.com',
               'password' => 'abcdef',
               'role_id' => 1
             }])
