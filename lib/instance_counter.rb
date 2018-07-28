# модуль подсчета созданных объектов класса
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :count
    # возвращает кол-во экземпляров данного класса
    def instances
      @count ||= 0
      @count
    end
  end

  module InstanceMethods
    protected

    # увеличивает счетчик кол-ва экземпляров класса
    def register_instance
      self.class.count ||= 0
      self.class.count += 1
    end
  end
end
