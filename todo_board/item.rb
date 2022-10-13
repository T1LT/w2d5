class Item
    def self.valid_date?(date)
        date = date.split("-")
        if date[0].length != 4
            return false
        elsif date[1].length != 2 || date[1].to_i > 12 || date[1].to_i < 1
            return false
        elsif date[2].length != 2 || date[2].to_i > 31 || date[2].to_i < 1
            return false
        end
        true
    end

    attr_reader :done
    attr_accessor :title, :deadline, :description
    def initialize(title, deadline, description)
        @title = title
        raise "invalid date!" if !Item.valid_date? deadline
        @deadline = deadline
        @description = description
        @done = false
    end

    def toggle
        @done = !@done
    end
end