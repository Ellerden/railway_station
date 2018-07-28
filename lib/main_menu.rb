#  модуль создает текстовый интерфейс для управления железной дорогой
module MainMenu
  OPTIONS = ['1 - Операции со станцией (создать, запросить поезда на станции, '\
             'список станций)',
             '2 - Операции с маршрутом (создать, управлять станциями на '\
             'маршруте и т.д.',
             '3 - Операции с поездом (создать, выбрать маршрут, перемещаться '\
             'по нему и т.д.)',
             '4 - Операции с вагонами (создать, добавить к поезду, отцепить)',
             '5 - Операции с билетами и грузами',
             '0 - выход'].freeze

  def show
    loop do
      puts OPTIONS
      input1 = gets.chomp.to_i
      case input1
      # Операции со станцией (создать, посмотреть список поездов на станции)
      when 1 then show_station_menu
      # Операции с маршрутом (создать, управлять станциями на маршруте и т.д.)
      when 2 then show_route_menu
      # Операции с поездом (создать, выбрать маршрут, двигаться по нему и т.д.)
      when 3 then show_train_menu
      # Операции с вагонами (создать, добавить к поезду, отцепить)
      when 4 then show_wagon_menu
      # Операции с билетами и грузами
      when 5 then show_ticket_menu
      # Выход
      when 0 then break
      end
    end
  end

  def show_station_menu
    station_menu = StationMenu.new
    input2 = gets.chomp.to_i
    station_menu.do_from_menu(input2)
  end

  def show_route_menu
    route_menu = RouteMenu.new
    input2 = gets.chomp.to_i
    route_menu.do_from_menu(input2)
  end

  def show_train_menu
    train_menu = TrainMenu.new
    input2 = gets.chomp.to_i
    train_menu.do_from_menu(input2)
  end

  def show_wagon_menu
    wagon_menu = WagonMenu.new
    input2 = gets.chomp.to_i
    wagon_menu.do_from_menu(input2)
  end

  def show_ticket_menu
    ticket_menu = TicketMenu.new
    input2 = gets.chomp.to_i
    ticket_menu.do_from_menu(input2)
  end
end
