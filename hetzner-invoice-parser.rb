require 'csv'
csv_file_name = ARGV[0]

search_server_name = ARGV[1]


ret = CSV.read(csv_file_name)
servers = {}
global_addons = []


ret.each do |record|
  next if record[0] != 'Servers'
  if record[2][0] == '#'
    #real server
    server_id = record[2].match(/^#\d+/).to_s
    server_name = record[2].match(/"([^"]+)"/)[1].to_s
    servers[server_id] = {name: server_name, quantity: record[5].to_i, item_price: record[6].to_f.round(2), total_price: record[7].to_f.round(2), addons: []}
  end
end

ret.each do |record|
  next if record[0] != 'Servers'
  if record[2][0] != '#'
    #addons
    if record[2].match(/Server (#\d+)/)
      server_id = record[2].match(/Server (#\d+)/)[1].to_s
    else
      splitted = record[2].split(',')
      if splitted.length == 1
        splitted = record[2].split("\n")
      end
      addon_name = splitted[0]
      global_addons << {name: addon_name, quantity: record[5].to_i, item_price: record[6].to_f.round(2), total_price: record[7].to_f.round(2)}
      next
    end
    splitted = record[2].split(',')
    if splitted.length == 1
      splitted = record[2].split("\n")
    end
    addon_name = splitted[0]
    servers[server_id][:addons] << {name: addon_name.gsub(/\n/, ' '), quantity: record[5].to_i, item_price: record[6].to_f, total_price: record[7].to_f}
  end
end

total_sum = 0

servers.each do |server_id, data|
  next if search_server_name and !data[:name].include?(search_server_name)

  server_total_cost = data[:total_price].to_f
  data[:addons].each do |addon|
    server_total_cost += addon[:total_price].to_f
  end
  total_sum += server_total_cost

  puts "Server #{server_id} #{data[:name]}. Total price with addons: #{server_total_cost.round(2)} euro"
  puts "Addons:" if data[:addons].any?
  data[:addons].each do |addon|
    puts "  - #{addon[:name]}: #{addon[:quantity].to_i} x #{addon[:item_price].round(2)} = #{addon[:total_price].round(2)} euro"
  end
  puts ""
end

puts "Global addons:" if global_addons.any?
global_addons.each do |addon|
  total_sum += addon[:total_price].round(2) if !search_server_name
  puts "- #{addon[:name]}: #{addon[:quantity].to_i} x #{addon[:item_price].round(2)} = #{addon[:total_price].round(2)} euro"
end

puts ""
puts "===================================="
if search_server_name
  puts "Servers are filtered by word: #{search_server_name}"
  puts "Total amount by filtered servers: #{total_sum.round(2)} euro"
  puts "Amount is calculated without global addons!"
else
  puts "Total amount with global addons: #{total_sum.round(2)} euro"
end
puts "All prices are without VAT!"
puts "===================================="

