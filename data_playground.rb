require 'JSON'

puts 'Reading the file...'
file = File.read('data.json')
data_hash = JSON.parse(file)
data_hash['id'] = '71'
File.write('data.json', JSON.dump(data_hash))
puts 'Rewriting complete!'