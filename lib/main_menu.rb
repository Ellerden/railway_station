#   создает текстовый интерфейс для управления железной дорогой
class MainMenu
  OPTIONS = ['1 - Операции со станцией (создать, запросить поезда на станции, '\
             'список станций)',
             '2 - Операции с маршрутом (создать, управлять станциями на '\
             'маршруте и т.д.',
             '3 - Операции с поездом (создать, выбрать маршрут, перемещаться '\
             'по нему и т.д.)',
             '4 - Операции с вагонами (создать, добавить к поезду, отцепить)',
             '5 - Операции с билетами и грузами',
             '0 - выход'].freeze
  MENU_METHODS = { 1 => :show_station_menu, 2 => :show_route_menu,
                   3 => :show_train_menu, 4 => :show_wagon_menu,
                   5 => :show_ticket_menu }.freeze

  def initialize
    loop do
      puts OPTIONS
      input1 = gets.chomp.to_i
      send MENU_METHODS[input1] || break
    end
  end

  # Операции со станцией (создать, посмотреть список поездов на станции)
  def show_station_menu
    station_menu = StationMenu.new
    input2 = gets.chomp.to_i
    station_menu.do_from_menu(input2)
  end

  # Операции с маршрутом (создать, управлять станциями на маршруте и т.д.)
  def show_route_menu
    route_menu = RouteMenu.new
    input2 = gets.chomp.to_i
    route_menu.do_from_menu(input2)
  end

  # Операции с поездом (создать, выбрать маршрут, двигаться по нему и т.д.)
  def show_train_menu
    train_menu = TrainMenu.new
    input2 = gets.chomp.to_i
    train_menu.do_from_menu(input2)
  end

  # Операции с вагонами (создать, добавить к поезду, отцепить)
  def show_wagon_menu
    wagon_menu = WagonMenu.new
    input2 = gets.chomp.to_i
    wagon_menu.do_from_menu(input2)
  end

  # Операции с билетами и грузами
  def show_ticket_menu
    ticket_menu = TicketMenu.new
    input2 = gets.chomp.to_i
    ticket_menu.do_from_menu(input2)
  end
end
