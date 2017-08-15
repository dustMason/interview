def timeConversion(s)
  if s[-2..-1] == "PM" && s[0..1].to_i < 12
    hour = s[0..1].to_i
    hour += 12
    return hour.to_s + s[2..-3]
  elsif s[-2..-1] == "AM" && s[0..1].to_i == 12
    return "00" + s[2..-3]
  else
    return s[0..-3]
  end
end

{
  "07:05:45PM" => "19:05:45",
  "12:45:54PM" => "12:45:54",
  "11:45:54PM" => "23:45:54",
  "01:45:54PM" => "13:45:54",
  "01:45:54AM" => "01:45:54",
  "12:05:00AM" => "00:05:00",
}.each do |input, output|
  result = timeConversion(input)
  if output == result
    puts "pass"
  else
    puts "fail"
    puts "given #{input} got #{result}. expected #{output}"
  end
end
