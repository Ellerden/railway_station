# encoding: UTF-8

# информация о вагонах поезда
module WagonsInfo

  def show_wagons_info
    self.show_all_wagons do |wagon, i|
      if wagon.type == :pass
        puts "Вагон № #{i}, тип: #{wagon.type}, всего мест: "\
        "#{wagon.places}, занято: #{wagon.taken_places}"
      else
        puts "Вагон № #{i}, тип: #{wagon.type}, общий объем: "\
        "#{wagon.capacity}(м^3), занято: #{wagon.taken_space}(м^3)"
      end
    end
  end
end
