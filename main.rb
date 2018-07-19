
require_relative "lib/station"
require_relative "lib/route"
require_relative "lib/train"
require_relative "lib/passengertrain"
require_relative "lib/cargotrain"
require_relative "lib/wagon"
require_relative "lib/passengerwagon"
require_relative "lib/cargowagon"

station1 = Station.new("Москва-Октябрьская")
station2 = Station.new("Тверь")
station3 = Station.new("Бологое")
station4 = Station.new("Санкт-Петербург Московский вокзал")
station5 = Station.new("Ростов Главный")
route1 = Route.new(station1, station4)
route1.add_station(station2)
route1.add_station(station5)
route1.add_station(station3)
route1.delete_station(station5)
#route1.show
#train1 = Train.new("Красная стрела", :pass, 12)
train1 = PassengerTrain.new("Красная стрела")
train1.begin_route(route1)
puts "ПОЕЗД В ОГНЕ #{train1.current_stop.name}"
station1.show_trains_by_type

wagon1 = PassengerWagon.new
wagon2 = PassengerWagon.new
wagon3 = PassengerWagon.new
train1.attach_wagon(wagon1)
train1.attach_wagon(wagon2)
train1.attach_wagon(wagon2)
train1.attach_wagon(wagon2)
puts train1.wagons

train1.detach_wagon(wagon1)
train1.detach_wagon(wagon3)

train1.attach_wagon(wagon2)
train1.attach_wagon(wagon2)

train1.accelerate
train1.accelerate
train1.stop
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


=begin
train2 = Train.new("Северное сияние", :pass, 9)
train3 = Train.new("121РДД", :cargo, 1)
train4 = Train.new("999ЦЦЦ", :cargo, 77)
train5 = Train.new("891ОРД", :cargo, 112)
train5.begin_route(route1)
station1.arrival(train2)
station1.arrival(train4)
station1.arrival(train3)
station1.show_trains_by_type
station1.show_trains_by_type(:cargo)
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
=end
