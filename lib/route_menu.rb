require_relative 'station'
require_relative 'main_menu'
require_relative 'route'
# Интерфейс меню для управления маршрутами
class RouteMenu
  OPTIONS = ['Выберите операцию: 1 - создать маршрут, 2 - добавить станцию, '\
              '3 - удалить станцию, 4 - посмотреть список всех станций, '\
              '0 - назад'].freeze
  MENU_METHODS = { 1 => :create_route,
                   2 => :add_station_to_route,
                   3 => :delete_station_from_route,
                   4 => :last_route_info }.freeze
  def initialize
    puts OPTIONS
  end

  def do_from_menu(choice)
    send MENU_METHODS[choice] || return
  end

  # к этим методам есть доступ только через do_from_menu,
  # используются внутри клаccа

  private

  # 1 - создать маршрут
  def create_route
    puts 'Введите начальную станцию (станция должна быть создана)'
    start = gets.chomp
    puts 'Введите конечную станцию (станция должна быть создана)'

    finish = gets.chomp
    Route.new(start, finish)
  rescue StandardError
    puts "Вагон #{wagon.company_name} типа #{wagon.type} создан" if wagon.valid?
  else
  end

  # 2 - добавить станцию
  def add_station_to_route
    puts 'Введите название станции, которую хотите добавить. Станция (должна '\
    'быть создана до этого) будет добавлена в последний созданный маршрут.'
    name = gets.chomp
    additional_station = Station.find_station_by_name(name)
    return if Route.empty?
    last_route = Route.last
    last_route.add_station(additional_station)
  end

  # 3 - удалить станцию
  def delete_station_from_route
    puts 'Введите название станции, которую хотите удалить. Станция (должна '\
    'быть создана до этого) будет удалена из последнего созданного маршрута'
    name = gets.chomp
    odd_station = Station.find_station_by_name(name)
    return if Route.empty?
    last_route = Route.last
    last_route.delete_station(odd_station)
  end

  # 4 - посмотреть список всех станций
  def last_route_info
    puts 'Информация о последнем добавленном маршруте:'
    return if Route.empty?
    last_route = Route.last
    puts last_route.all_stations
  end
end
