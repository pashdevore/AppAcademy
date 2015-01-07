url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/cat_rental_requests'
).to_s

puts RestClient.get(url)
