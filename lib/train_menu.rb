# encoding: UTF-8
require_relative 'route'
require_relative 'station'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'wagon'
require_relative 'main_menu'
require_relative 'train'

class TrainMenu
  def initialize
    puts "Выберите операцию: 1 - создать поезд, 2 - выбрать маршрут поезда, "\
    "3 - вперед по маршруту, 4 - назад по маршруту. 0 - назад"
  end

  def do_from_menu(choice)
    case choice
      # создать поезд
    when 1
      puts 'Выберите тип поезда, который вы хотите создать: 1 - пасс, 2 - груз.'
      type = gets.chomp.to_i
      puts 'Введите название поезда, который вы хотите создать'
      name = gets.chomp

      case type
      when 1
        train = PassengerTrain.new(name)
        puts "Пассажирский поезд #{train.num} создан"
      when 2
        train = CargoTrain.new(name)
        puts "Грузовой поезд #{train.num} создан"
      else
        puts 'Таких поездов мы пока не делаем'
      end

       # выбрать маршрут
    when 2
      puts 'Какой поезд вы хотите поставить на маршрут? Введите название'
      name = gets.chomp
      selected_train = Train.find_train_by_name(name)
      unless selected_train.nil?
        puts 'Выберите один из маршрутов: '
        Route.show_all
        choice = gets.chomp.to_i
        selected_route = Route.by_index(choice)
        selected_train.begin_route(selected_route)
        puts 'Поезд вышел на маршрут!'
      end

        # вперед по маршруту
    when 3
      puts 'Какой поезд вы хотите продвинуть вперед? Введите название'
      name = gets.chomp
      selected_train = Train.find_train_by_name(name)
      puts selected_train
      unless selected_train.nil? || selected_train.current_stop.nil?
        puts "Следующая станция — #{selected_train.next_stop.name}"
        selected_train.forward
        puts 'Поезд отправился вперед'
      end

        # назад по маршруту
    when 4
      puts 'Какой поезд вы хотите отправить назад? Введите название'
      name = gets.chomp
      selected_train = Train.find_train_by_name(name)
      unless selected_train.nil? || selected_train.current_stop.nil?
        puts "Предыдущая станция — #{selected_train.last_stop.name}"
        selected_train.backward
        puts 'Поезд отправился назад'
      end
        # назад к главному меню
    when 0
      MainMenu.show
    end
  end
end
