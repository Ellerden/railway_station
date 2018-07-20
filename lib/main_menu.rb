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
          puts Station.menu
          input2 = gets.chomp.to_i
          Station.do_from_menu(input2)
# Операции с маршрутом (создать, управлять станциями на маршруте и т.д.)
        when 2
          puts Route.menu
          input2 = gets.chomp.to_i
          Route.do_from_menu(input2)
# Операции с поездом (создать, выбрать маршрут, перемещаться по нему и т.д.)
        when 3
          puts Train.menu
          input2 = gets.chomp.to_i
          Train.do_from_menu(input2)
# Операции с вагонами (создать, добавить к поезду, отцепить)"
        when 4
          puts Wagon.menu
          input2 = gets.chomp.to_i
          Wagon.do_from_menu(input2)
        when 0
          break
      end
    end
  end
end