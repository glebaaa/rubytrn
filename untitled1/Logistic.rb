require "net/http"
require "openssl"
require "json"

token = "Ha5RBiYsBEhrT1XUucP4XxQPnTdzT"

tovar  = {'weight' => 1, 'length' => 1, 'width' => 1, 'height' => 1000,'distance' => 1,'price' => 1}

puts("вес(кг)")
tovar['weight'] = gets.chomp.to_f
puts("длина(см)")
tovar['length'] = gets.chomp.to_f
puts("ширина(см)")
tovar['width'] = gets.chomp.to_f
puts("высота(см)")
tovar['height'] = gets.chomp.to_f
puts("название пункта отправления")
origin_address = gets.chomp
puts("название пункта назначения")
destination_address = gets.chomp

origin_address = '45.055800,39.018194'
destination_address ='43.615000,39.724783'

link = "https://api.distancematrix.ai/maps/api/distancematrix/json?origins="+origin_address+"&destinations="+destination_address+"&key="+token
url = link
resp = Net::HTTP.get_response(URI.parse(url))
data = JSON.parse(resp.body)
tovar['distance'] = data['rows'][0]['elements'][0]['distance']['value'].to_f/1000
puts (tovar)

if tovar['length'] * tovar['width'] * tovar['height']<1000000
  tovar['price'] = tovar['distance']
end

if tovar['length'] * tovar['width'] * tovar['height']>1000000
  if tovar['weight'] < 10
    tovar['price'] = tovar['distance'] * 2
  end
end

if tovar['length'] * tovar['width'] * tovar['height']>1000000 && tovar['weight'] > 10
  tovar['price'] = tovar['distance'] * 3
end

puts (tovar)