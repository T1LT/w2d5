require_relative "./list.rb"
require_relative "./item.rb"

class TodoBoard
    def initialize
        @board = {}
    end

    def get_command
        print "Enter a command: "
        cmd, *args = gets.chomp.split(" ")
        case cmd
        when "mklist"
            @board[*args] = List.new(*args)
        when "ls"
            @board.keys.each do |label|
                puts label
            end
        when "showall"
            @board.values.each do |list|
                list.print
            end
        when "mktodo"
            @board[args[0]].add_item(*args[1..-1])
        when "up"
            @board[args[0]].up(*args[1..-1])
        when "down"
            @board[args[0]].add_item(*args[1..-1])
        when "swap"
            @board[args[0]].swap(*args[1..-1])
        when "sort"
            @board[args[0]].sort_by_date!
        when "priority"
            @board[args[0]].print_priority
        when "print"
            if args.length == 1
                @board[args[0]].print
            else
                @board[args[0]].print_full_item(args[1])
            end
        when "toggle"
            @board[args[0]].toggle_item(*args[1..-1])
        when "rm"
            @board[args[0]].remove_item(*args[1..-1])
        when "purge"
            @board[args[0]].purge
        when "quit"
            return false
        else
            puts "invalid command!"
        end
        true
    end
    
    def run
        while self.get_command
            self.get_command
        end
    end
end

b = TodoBoard.new
b.run