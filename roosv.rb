require 'spreadsheet'
class Roosv

  attr_reader :default_sheet

  def initialize(file_name)
    setup(file_name)
    @default_sheet = self.sheets.first
  end

  def setup(file)
    array = []
    begin
      CSV.foreach(file) do |row|
        array << row
      end
    rescue
      array = CSV.read(file, encoding: "ASCII-8BIT:ASCII-8BIT")
    end
    @array = array
  end

  def default_sheet=(sheet)
    @default_sheet = sheet
  end

  def first_row(sheet=nil)
    1
  end

  def last_row(sheet=nil)
    @array.length
  end

  def first_column(sheet=nil)
    1
  end

  def last_column(sheet=nil)
    @array[0].length 
  end

  def sheets
    result = []
    result << 'sheet1'
    return result
  end

  def celltype(row,col)
    :string
  end

  def cell(row,col,sheet=nil)
    begin
      if col.class == String
        col = letter_to_number(col)
      end
      @array[row - 1][col - 1]
    rescue
      nil
    end
  end

  def array
    @array
  end

  def letter_to_number(letters)
    result = 0
    while letters && letters.length > 0
      character = letters[0,1].upcase
      num = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(character)
      raise ArgumentError, "invalid column character '#{letters[0,1]}'" if num ==nil
      num += 1
      result = result * 26 + num
      letters = letters[1..-1]
    end
    result
  end

end

