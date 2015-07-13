# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Type.create(name: 'Spool')
Type.create(name: 'Supports')
Type.create(name: 'Loose Piping Items')

Rule.create(search_text: 'BLIND FLANGE', display_text: '#{dn} #{designation}')
Rule.create(search_text: 'STUD BOLT / NUTS', display_text: '#{dn_2} x #{dimension_1} #{designation}')