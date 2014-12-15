class FileSort

  def shuffle_file(file_name)
    shuffled_array = File.readlines(file_name).map { |line| line.chomp }
    shuffled_array.shuffle!
    write_to_new_file(file_name[0...-4], shuffled_array)
  end

  def write_to_new_file(prev_name, shuffled_array)
    file_name = "#{prev_name}-shuffled.txt"
    f = File.open(file_name, "w+")
    shuffled_array.each do |w|
      f.puts w
    end
    f.close
  end

end

p FileSort.new.shuffle_file("rpn.txt")
