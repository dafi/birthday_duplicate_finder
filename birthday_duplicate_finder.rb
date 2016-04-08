#!/usr/bin/env ruby
def read_bdays(bday_csv_path)
    map = {}

    open(bday_csv_path).read.gsub(/\r\n?/, "\n").each_line do |line|
        (id, name, bday, blog) = line.split(';')
        list = map[bday]
        if list == nil
            list = []
            map[bday] = list
        end
        list.push(name)
    end

    return map.delete_if { |k,v| v.size == 1}
end

def find_similar(map)
    map.each do |bday,list|
        for i in 0..list.count-1
            iwords = list[i].split(/[ -]/)
            for j in (i + 1)..list.count-1
                jwords = list[j].split(/[ -]/)
                arr = iwords & jwords
                if !arr.empty?
                    puts "#{bday} '#{list[i]}' with '#{list[j]}' = #{arr}"
                end
            end
        end
    end
end

if ARGV.empty?
  puts 'Specify the path to birthday CSV file'
  exit
end

map = read_bdays(ARGV[0])
find_similar(map)
