# encoding: UTF-8
module MainMenu
  def show
    loop do
      input1 = nil
      puts '1 - Операции со станцией (создать, посмотреть список поездов на станции)'
      puts '2 - Операции с маршрутом (создать, управлять станциями на маршруте и т.д.)'
      puts '3 - Операции с поездом (создать, выбрать маршрут, перемещаться по нему и т.д.)'
      puts '4 - Операции с вагонами (создать, добавить к поезду, отцепить)'
      puts '0 - выход'
      input1 = gets.chomp.to_i

      case input1
# Операции со станцией (создать, посмотреть список поездов на станции)"
        when 1
          station_menu = StationMenu.new
          input2 = gets.chomp.to_i
          station_menu.do_from_menu(input2)
# Операции с маршрутом (создать, управлять станциями на маршруте и т.д.)
        when 2
          route_menu = RouteMenu.new
          input2 = gets.chomp.to_i
          route_menu.do_from_menu(input2)
# Операции с поездом (создать, выбрать маршрут, перемещаться по нему и т.д.)
        when 3
          train_menu =TrainMenu.new
          input2 = gets.chomp.to_i
          train_menu.do_from_menu(input2)
# Операции с вагонами (создать, добавить к поезду, отцепить)"
        when 4
          wagon_menu = WagonMenu.new
          input2 = gets.chomp.to_i
          wagon_menu.do_from_menu(input2)
        when 0
          break
      end
    end
  end
end