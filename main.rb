
require_relative "station"
require_relative "route"
require_relative "train"

station1 = Station.new("Москва-Октябрьская")
station2 = Station.new("Тверь")
station3 = Station.new("Бологое")
station4 = Station.new("Санкт-Петербург Московский вокзал")
station5 = Station.new("Ростов Главный")

route1 = Route.new(station1, station2, station5, station4)
route1.add_station(station3)
route1.delete_station(station5)
route1.show

train1 = Train.new("Красная стрела", "Пассажирский", 12)
train2 = Train.new("Северное сияние", "Пассажирский", 9)
train1.accelerate
train1.accelerate
train1.stop
train1.detach_car
train1.attach_car
train1.begin_route(route1)
train1.forward
puts "Остановка: #{train1.current_stop.name}"
puts "Предыдущая остановка: #{train1.last_stop.name}"
puts "Следующая остановка: #{train1.next_stop.name}"
train1.forward
train1.forward
train1.backward
train1.backward
train1.backward
station1.arrival(train2)
puts station1.trains_count("пассажирский")
