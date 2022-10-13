require_relative "./item.rb"

class List
    attr_accessor :label
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = "")
        return false if !Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end

    def size
        @items.length
    end

    def valid_index?(idx)
        idx = idx.to_i if !idx.is_a? Integer
        return false if idx >= self.size || idx < 0
        true
    end
    
    def swap(idx1, idx2)
        return false if !self.valid_index?(idx1) || !self.valid_index?(idx2)
        @items[idx1.to_i], @items[idx2.to_i] = @items[idx2.to_i], @items[idx1.to_i]
    end

    def [](idx)
        return nil if !self.valid_index?(idx)
        @items[idx.to_i]
    end

    def []=(idx, value)
        return nil if !self.valid_index?(idx)
        @items[idx.to_i] = value
    end

    def priority
        self[0]
    end

    def print
        puts "------------------------------------------"
        puts @label.upcase
        puts "------------------------------------------"
        puts "Index\t | Item\t\t | Deadline \t\t | Done"
        @items.each_with_index do |item, idx|
            puts "#{idx}\t | #{item.title}\t\t | #{item.deadline}\t\t | #{item.done}"
        end
    end

    def print_full_item(idx)
        puts "-----------------"
        puts self[idx].title
        puts self[idx].deadline
        puts self[idx].description
        puts self[idx].done
        puts "-----------------"
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(idx, amt = 1)
        idx = idx.to_i
        amt = amt.to_i
        amt.times do
            if self.valid_index?(idx - 1)
                self.swap(idx, idx - 1)
                idx -= 1
            end
            false
        end
    end

    def down(idx, amt = 1)
        idx = idx.to_i
        amt = amt.to_i
        amt.times do
            if self.valid_index?(idx + 1)
                self.swap(idx, idx + 1)
                idx += 1
            end
            false
        end
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(idx)
        idx = idx.to_i
        self[idx].toggle
    end

    def remove_item(idx)
        idx = idx.to_i
        @items -= [self[idx]]
    end

    def purge
        @items.select! { |item| !item.done }
    end
end