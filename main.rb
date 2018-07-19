require_relative "lib/station"
require_relative "lib/route"
require_relative "lib/train"
require_relative "lib/passengertrain"
require_relative "lib/cargotrain"
require_relative "lib/wagon"
require_relative "lib/passengerwagon"
require_relative "lib/cargowagon"

puts "Добро пожаловать на железную дорогу. Что вы хотите сделать?"
station = []
train = []
wagon = []
route = []

loop do
input1 = nil
input2 = nil
puts "1 - Операции со станцией (создать, посмотреть список поездов на станции)"
puts "2 - Операции с маршрутом (создать, управлять станциями на маршруте и т.д.)"
puts "3 - Операции с поездом (создать, выбрать маршрут, перемещаться по нему и т.д.)"
puts "4 - Операции с вагонами (создать, добавить к поезду, отцепить)"
#puts "9 - назад"
puts "0 - выход"
input1 = gets.chomp.to_i

  case input1
# Операции со станцией (создать, посмотреть список поездов на станции)"
    when 1
      puts "Выберите операцию: 1 - создать станцию, 2 - посмотреть список поездов"\
      " на станции. 0 - назад"
      input2 = gets.chomp.to_i
      case input2
        # создать станцию
        when 1
          puts "Введите название станции, которую вы хотите создать"
          name = gets.chomp
          station << Station.new(name)
          puts "Станция #{station.last.name} создана"

        # список поездов на станции
        when 2
          puts "Введите название станции, чтобы посмотреть список поездов"
          name = gets.chomp
          station.each do |station|
            station.show_trains_by_type if station.name == name
          end

        when 0
          puts "Назад, так назад"
      end

# - Операции с маршрутом (создать, управлять станциями на маршруте и т.д.)
    when 2
      puts "Выберите операцию: 1 - создать маршрут, 2 - добавить станцию, "\
      "3 - удалить станцию, 4 - посмотреть список всех станций, 0 - назад"
      input2 = gets.chomp.to_i
      case input2

        # 1 - создать маршрут
        when 1
          puts "Введите начальную станцию"
          start = gets.chomp
          starting_station = station.select { |station| station.name == start}
          # если такой станции нет - мы ее создаем
          if starting_station.empty?
            station << Station.new(start)
            starting_station = station.last
          end

          puts "Введите конечную станцию"
          finish = gets.chomp
          # если такой станции нет - мы ее создаем
          terminal_station = station.select { |station| station.name == finish}

          if terminal_station.empty?
            station << Station.new(finish)
            terminal_station = station.last
          end

          route << Route.new(starting_station, terminal_station)
          puts "Маршрут от #{start} до #{finish} создан"

        # 2 - добавить станцию
        when 2
          puts "Введите название станции, которую хотите добавить. "\
          "Станция будет добавлена в последний созданный маршрут"
          name = gets.chomp

          additional_station = station.select { |station| station.name == name}

          if additional_station.empty?
            station << Station.new(name)
            additional_station = station.last
          end

          route.last.add_station(additional_station)
          puts "Станция #{name} добавлена!"

          # 3 - удалить станцию
          when 3
            puts "Введите название станции, которую хотите удалить. "\
            "Станция будет удалена из последнего созданного маршрута"
            name = gets.chomp

            odd_station = station.select { |station| station.name == name}

            if odd_station.empty?
              station << Station.new(name)
              odd_station = station.last
            end

            route.last.delete_station(odd_station)
            puts "Станция #{name} удалена!"

        # 4 - посмотреть список всех станций,
        when 4
          puts "Информация о последнем добавленном маршруте:"
          unless route.empty?
            route.last.show
          end

        when 0
          puts "Назад, так назад"
      end

# Операции с поездом (создать, выбрать маршрут, перемещаться по нему и т.д.)
    when 3
      puts "Выберите операцию: 1 - создать поезд, 2 - выбрать маршрут поезда, "\
      "3 - вперед по маршруту, 4 - назад по маршруту. 0 - назад"
      input2 = gets.chomp.to_i

      case input2

        # создать поезд
        when 1
          puts "Выберите тип поезда, который вы хотите создать: 1 - пасс, 2 - груз."
          type = gets.chomp.to_i
          puts "Введите название поезда, который вы хотите создать"
          name = gets.chomp
          case type
            when 1
              train << PassengerTrain.new(name)
              puts "Пассажирский поезд #{name} создан"
            when 2
              train << CargoTrain.new(name)
              puts "Грузовой поезд #{name} создан"
            else
              puts "Таких поездов мы пока не делаем"
          end

       # выбрать маршрут
        when 2
          puts "Маршрут будет назначен последнему созданному поезду"
          puts "Выберите один из маршрутов: "
          route.each_with_index do |route, index|
            puts "#{index + 1}"
            route.show
            puts "................"
          end
          choice = gets.chomp.to_i

          train.last.begin_route(route[choice - 1])
          puts "Поезд вышел на маршрут!"

        # вперед по маршруту
        when 3
          puts "Какой поезд вы хотите продвинуть вперед? Введите название"
          name = gets.chomp
          train.each do |train|
            if train.num == name && !train.current_stop.nil?
              puts "Следующая станция — #{train.next_stop.name}"
              train.forward
              puts "Поезд отправился вперед"
            end
          end

        # назад по маршруту
        when 4
          puts "Какой поезд вы хотите отправить назад? Введите название"
          name = gets.chomp
          train.each do |train|
            if train.num == name && !train.current_stop.nil?
              puts "Предыдущая станция — #{train.last_stop.name}"
              train.backward
              puts "Поезд отправляется назад"
            end
          end

        when 0
          puts "Назад, так назад"
      end

# Операции с вагонами (создать, добавить к поезду, отцепить)"
    when 4
      puts "Выберите операцию: 1 - создать вагон, 2 - прицепить вагон к поезду, "\
      "3 - отцепить вагон от поезда. 0 - назад"
      input2 = gets.chomp.to_i

      case input2
        #создать вагон
        when 1
          puts "Выберите тип вагона, который вы хотите создать: 1 - пасс, 2 - груз."
          type = gets.chomp.to_i
          case type
            when 1
              wagon << PassengerWagon.new
              puts "Пассажирский вагон создан"
            when 2
              wagon << CargoWagon.new
              puts "Грузовой вагон создан"
            else
              puts "Таких вагонов у нас нет"
          end

        #добавить вагон к поезду
        when 2
          puts "Введите название поезда, к которому цеплять вагон. "\
          " К поезду будет прицеплен последний созданный вагон"
          name = gets.chomp
          train.each do |train|
            if train.num == name
              train.attach_wagon(wagon.last)
              puts "Вагон успешно прицеплен"
            end
          end

        # отцепить вагон от поезда
        when 3
          puts "Введите название поезда, от которого отцеплять вагон "\
          "Будет отцеплен последний вагон в поезде"
          name = gets.chomp
          train.each do |train|
            if train.num == name
              train.detach_wagon
              puts "Вагон успешно отцеплен"
            end
        end

        when 0
          puts "Назад, так назад"
      end

    when 0
      break
  end
end
