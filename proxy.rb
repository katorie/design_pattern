class Printer
  def initialize(name)
    @name = name
    heavy_job('Printerのインスタンスを生成中')
  end

  def set_printer_name(name)
    @name = name
  end

  def print(string)
    pp "===#{@name}==="
    pp string
  end

  private

  def heavy_job(message)
    pp message
    pp '----------'
    sleep(3)
    pp '完了しました'
  end
end

class PrinterProxy
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def set_printer_name(name)
    unless @real.nil?
      @real.set_printer_name(name)
    end
    @name = name
  end

  def print(string)
    realize
    @real.print(string)
  end

  private

  def realize
    @real ||= Printer.new(name)
  end
end

printable = PrinterProxy.new('alice')
pp "名前は現在 #{printable.name} です"

printable.set_printer_name('bob')
pp "名前は現在 #{printable.name} です"

printable.print('Hello World')
