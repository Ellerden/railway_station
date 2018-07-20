# encoding: UTF-8
require_relative 'station'
require_relative 'main_menu'
require_relative 'route'

class RouteMenu
  def initialize
    puts "Выберите операцию: 1 - создать маршрут, 2 - добавить станцию, "\
    "3 - удалить станцию, 4 - посмотреть список всех станций, 0 - назад"
  end

  def do_from_menu(choice)
    case choice
      # 1 - создать маршрут
    when 1
      puts 'Введите начальную станцию'
      start = gets.chomp
      starting_station = Station.find_station_by_name(start)
        # если такой станции нет, она будет создана
      starting_station = Station.new(start) if starting_station.nil?
      puts 'Введите конечную станцию'
      finish = gets.chomp
      terminal_station = Station.find_station_by_name(finish)
        # если такой станции нет, она будет создана
      terminal_station = Station.new(finish) if terminal_station.nil?
      new_route = Route.new(starting_station, terminal_station)
      puts "Маршрут от #{new_route.starting_station.name} до "\
      " #{new_route.terminal_station.name} создан"

      # 2 - добавить станцию
    when 2
      puts 'Введите название станции, которую хотите добавить. '\
      'Станция будет добавлена в последний созданный маршрут'
      name = gets.chomp
      additional_station = Station.find_station_by_name(name)
        # если такой станции нет, она будет создана
      additional_station = Station.new(name) if additional_station.nil?

      last_route = Route.last
      last_route.add_station(additional_station)
      puts "Станция #{additional_station.name} добавлена!"

        # 3 - удалить станцию
    when 3
      puts 'Введите название станции, которую хотите удалить. '\
      'Станция будет удалена из последнего созданного маршрута'
      name = gets.chomp
      odd_station = Station.find_station_by_name(name)
      # если такой станции нет в списке станций, она будет создана
      odd_station = Station.new(name) if odd_station.nil?
      last_route = Route.last
      last_route.delete_station(odd_station)
      puts "На станции #{odd_station.name} поезд больше не остановится"

      # 4 - посмотреть список всех станций,
    when 4
      puts 'Информация о последнем добавленном маршруте:'
      unless Route.empty?
        last_route = Route.last
        last_route.show
      end

      # назад к главному меню
    when 0
      MainMenu.show
    end
  end
end
