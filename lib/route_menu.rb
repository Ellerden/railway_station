# encoding: UTF-8

require_relative 'station'
require_relative 'main_menu'
require_relative 'route'
# Интерфейс меню для управления маршрутами
class RouteMenu
  def initialize
    puts 'Выберите операцию: 1 - создать маршрут, 2 - добавить станцию, '\
    '3 - удалить станцию, 4 - посмотреть список всех станций, 0 - назад'
  end

  def do_from_menu(choice)
    case choice
      # 1 - создать маршрут
    when 1 then create_route
      # 2 - добавить станцию
    when 2 then add_station_to_route
      # 3 - удалить станцию
    when 3 then delete_station_from_route
      # 4 - посмотреть список всех станций,
    when 4 then last_route_info
      # назад к главному меню
    when 0 then return
    end
  end

# к этим методам есть доступ только через do_from_menu,
# используются внутри клаccа
  private

  def create_route
    puts 'Введите начальную станцию (станция должна быть создана)'
    start = gets.chomp
    starting_station = Station.find_station_by_name(start)
    puts 'Введите конечную станцию (станция должна быть создана)'
    finish = gets.chomp
    terminal_station = Station.find_station_by_name(finish)
    unless terminal_station.nil? && starting_station.nil?
      new_route = Route.new(starting_station, terminal_station)
      puts "Маршрут от #{new_route.starting_station.name} до "\
      "#{new_route.terminal_station.name} создан"
    end
  end

  def add_station_to_route
    puts 'Введите название станции, которую хотите добавить. Станция (должна '\
    'быть создана до этого) будет добавлена в последний созданный маршрут.'
    name = gets.chomp
    additional_station = Station.find_station_by_name(name)
    unless additional_station.nil?
      last_route = Route.last
      last_route.add_station(additional_station)
      puts "Станция #{additional_station.name} добавлена!"
    end
  end

  def delete_station_from_route
    puts 'Введите название станции, которую хотите удалить. Станция (должна '\
    'быть создана до этого) будет удалена из последнего созданного маршрута'
    name = gets.chomp
    odd_station = Station.find_station_by_name(name)
    unless odd_station.nil?
      last_route = Route.last
      last_route.delete_station(odd_station)
      puts "На станции #{odd_station.name} поезд больше не остановится"
    end
  end

  def last_route_info
    puts 'Информация о последнем добавленном маршруте:'
    unless Route.empty?
      last_route = Route.last
      puts last_route.all_stations
    end
  end
end
