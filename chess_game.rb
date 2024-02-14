module Chess
  CHESSBOARD = [["T", "H", "B", "Q", "K", "B", "H", "T"],
                ["P", "P", "P", "P", "P", "P", "P", "P"],
                ["-", "-", "-", "-", "-", "-", "-", "-"],
                ["-", "-", "-", "-", "-", "-", "-", "-"],
                ["-", "-", "-", "-", "-", "-", "-", "-"],
                ["-", "-", "-", "-", "-", "-", "-", "-"],
                ["p", "p", "p", "p", "p", "p", "p", "p"],
                ["t", "h", "b", "q", "k", "b", "h", "t"]
  ]

  TEMP_CHESSBOARD = [["T", "H", "B", "Q", "K", "B", "H", "T"],
                    ["P", "P", "P", "P", "P", "P", "P", "P"],
                    ["-", "-", "-", "-", "-", "-", "-", "-"],
                    ["-", "-", "-", "-", "-", "-", "-", "-"],
                    ["-", "-", "-", "-", "-", "-", "-", "-"],
                    ["-", "-", "-", "-", "-", "-", "-", "-"],
                    ["p", "p", "p", "p", "p", "p", "p", "p"],
                    ["t", "h", "b", "q", "k", "b", "h", "t"]
  ]

  COLUMNS = {
    'A' => 0,
    'B' => 1,
    'C' => 2,
    'D' => 3,
    'E' => 4,
    'F' => 5,
    'G' => 6,
    'H' => 7,
  }

  def self.print()
    CHESSBOARD.reverse.each_with_index do |row,ind|
      puts "#{ind+1}  #{row.join("  ")}"
    end
    puts [" ","A", "B", "C", "D", "E", "F", "G", "H"].join("  ")
  end

  def self.translate_from(pos) # accepts "A6" - Returns [0,5]
    @column = COLUMNS[pos[0]]
    @row = pos[1].to_i - 1
    return [@column,@row]
  end

  def self.translate_to(pos) # accepts [0,5] - Returns "A6"
    column = COLUMNS.key(pos[0])
    row = (pos[1] + 1).to_s
    return "#{column}#{row}"
  end

  def self.remove(pos)
    translate_from(pos)

    CHESSBOARD[@row][@column] = '-'
  end

  def self.set(pos, piece)
    translate_from(pos)

    CHESSBOARD[@row][@column] = piece
  end

  def self.getPiece(pos)
    translate_from(pos)

    return CHESSBOARD[@row][@column]
  end

  def self.move(originalPos, futurePos)
    piece = getPiece(originalPos)

    remove(originalPos)

    set(futurePos,piece)
  end

  def self.availableMove(pos)
    piece = getPiece(pos)
    translate_from(pos)
    @availableMoves = []

    case piece
    when 'P'
      movementPawn(pos)
    when 'T'
    movementTower(pos)
    when 'B'
    movementBishop(pos)
    when 'H'
      puts "horse not yet"
    when 'K'
      movementKing(pos)
    when 'Q'
      movementQueen(pos)
    end
    @availableMoves.each do |i|
      set(translate_to(i), 'X')
    end
  end


  def self.movementPawn(pos)
    translate_from(pos)

    @availableMoves << [@column,@row+1]
    if @row == 1
      @availableMoves << [@column,@row+2]
    end
    return @availableMoves.uniq
  end


  def self.movementBishop(pos)
    translate_from(pos)

    diagonals(@column,@row).each do |pos|
      @availableMoves << pos
    end

    return @availableMoves.uniq
  end


  def self.movementTower(pos)
    translate_from(pos)

    cross(@column,@row).each do |pos|
      @availableMoves << pos
    end

    return @availableMoves.uniq
  end


  def self.movementKing(pos)
    translate_from(pos)

    (@column-1..@column+1).each do |col|
      (@row-1..@row+1).each do |row|
        @availableMoves << [col,row]
      end
    end

    return @availableMoves.uniq
  end


  def self.movementQueen(pos)
    translate_from(pos)

    cross(@column,@row).each do |pos|
      @availableMoves << pos
    end
    diagonals(@column,@row).each do |pos|
      @availableMoves << pos
    end

    puts @availableMoves.uniq.to_s
  end

  #auxiliar functions

  private
  def self.diagonals(colInput,rowInput)
    diagonal = []
    (0..7).each do |col|
      (0..7).each do |row|
        if (col - row == colInput - rowInput) || (col + row == colInput + rowInput)
          diagonal << [col,row]
        end
      end
    end
    return diagonal
  end

  def self.cross(colInput,rowInput)
    cross = []
    (0..7).each do |col|
      cross << [col, rowInput]
    end
    (0..7).each do |row|
      cross << [colInput, row]
    end
    return cross
  end

end

# Chess.movementQueen('D3')

# puts Chess.translate_from('C4')
# Chess.diagonals(2,5)

# Chess.availableMove('A2')

Chess.print()
puts "-----------------------------------------------------------"
Chess.availableMove("D1")
# Chess.move("B","1","C","3")
puts "-----------------------------------------------------------"
Chess.print()