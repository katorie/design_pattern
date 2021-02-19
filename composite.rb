class Entry
  class FileTreatmentException < StandardError; end

  def add
    raise FileTreatmentException
  end

  def to_string
    "#{name}(#{size});"
  end
end

class FileEntry < Entry
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def print_list(prefix)
    pp "#{prefix}/#{to_string}"
  end
end

class DirectoryEntry < Entry
  attr_reader :name

  def initialize(name)
    @name = name
    @entries = []
  end

  def size
    size = 0
    @entries.sum(&:size)
  end

  def add(entry)
    @entries << entry
  end

  def print_list(prefix = "")
    pp "#{prefix}/#{to_string}"

    @entries.each do |entry|
      entry.print_list("#{prefix}/#{name}")
    end
  end
end

begin
  root_dir = DirectoryEntry.new('root')
  bin_dir = DirectoryEntry.new('bin')
  tmp_dir = DirectoryEntry.new('tmp')
  usr_dir = DirectoryEntry.new('usr')
  root_dir.add(bin_dir)
  root_dir.add(tmp_dir)
  root_dir.add(usr_dir)

  bin_dir.add(FileEntry.new('vi', 10000))
  bin_dir.add(FileEntry.new('latex', 20000))

  root_dir.print_list

  yuki = DirectoryEntry.new('yuki')
  hanako = DirectoryEntry.new('hanako')
  tomura = DirectoryEntry.new('tomura')

  usr_dir.add(yuki)
  usr_dir.add(hanako)
  usr_dir.add(tomura)

  yuki.add(FileEntry.new('diary.html', 100))
  yuki.add(FileEntry.new('Composite.java', 200))
  hanako.add(FileEntry.new('memo.txt', 300))
  tomura.add(FileEntry.new('game.doc', 400))
  tomura.add(FileEntry.new('junmk.mail', 500))

  root_dir.print_list
rescue Entry::FileTreatmentException
  pp '追加できません！'
end