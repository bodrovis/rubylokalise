# frozen_string_literal: true

module RubyLokaliseApi
  class Generics
    include RubyLokaliseApi::Concerns::HashAccessible

    DeletedResource = Class.new(self)
    EmptiedResource = Class.new(self)
    CustomStatusAvailableColors = Class.new(self)
    DownloadBundle = Class.new(self)

    def initialize(raw_data)
      raw_data.each do |att, val|
        instance_variable_set "@#{att}", val

        self.class.class_exec do
          attr_reader att.to_sym
        end
      end
    end
  end
end
