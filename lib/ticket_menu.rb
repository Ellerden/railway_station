# encoding: UTF-8
require_relative 'train'
require_relative 'main_menu'
require_relative 'wagon'

class TicketMenu
 # include WagonInfo

  def initialize
    puts 'Выберите операцию: 1 - купить билет на поезд, 2 - отправить груз. '\
    '0 - назад'
  end

  def do_from_menu(choice)
    case choice
      # купить билет в пассажирский вагон
    when 1 then buy_ticket
      # отправить груз в грузовом вагоне
    when 2 then ship_package
      # назад в главное меню
    when 0 then return
    end
  end
# к этим методам есть доступ только через do_from_menu,
# используются внутри клаccа
  private
  def buy_ticket
    puts 'Введите номер поезда, в котором вы хотите купить билет. '
    name = gets.chomp
    selected_train = Train.find(name)
    if selected_train && selected_train.type == :pass && selected_train.wagons
      selected_train.show_wagons_info
      puts 'Выберите вагон, в котором вы хотите поехать. Введите номер'
      num = gets.chomp.to_i
      selected_train.wagons[num - 1].take_place
      puts "Место успешно забронировано! Осталось свободных мест: "\
      "#{selected_train.wagons[num - 1].places}"
    end
  end

  def ship_package
    puts 'Введите номер поезда, в котором вы хотите отправить груз. '
    name = gets.chomp
    selected_train = Train.find(name)
    if selected_train && selected_train.type == :cargo && selected_train.wagons
      selected_train.show_wagons_info
      puts 'Выберите вагон, в котором вы будете отправлять груз. Введите номер'
      num = gets.chomp.to_i
      puts 'Введите объем груза'
      space = gets.chomp.to_i
      selected_train.wagons[num - 1].occupy_space
      puts "Груз успешно добавлен! Осталось свободного объема: "\
      "#{selected_train.wagons[num - 1].capacity}"
    end
  end
end

