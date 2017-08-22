# https://www.hackerrank.com/challenges/the-time-in-words

def time_in_words hours, minutes
  return "#{int_as_word(hours)} o'clock" if minutes == 0
  
  unit = if minutes % 30 == 0
    'half'
  elsif minutes % 15 == 0
    'quarter'
  elsif minutes <= 30
    [int_as_word(minutes), minutes(minutes)].join(' ')
  else
    [int_as_word(60-minutes), minutes(minutes)].join(' ')
  end
  
  if minutes <= 30
    "#{unit} past #{int_as_word(hours)}"
  else
    "#{unit} to #{int_as_word(hours + 1)}"
  end
end

def int_as_word n
  words = %w{one two three four five six seven eight nine ten eleven twelve thirteen
  fourteen fifteen sixteen seventeen eighteen nineteen twenty}
  if n > 20
    [words[19], words[n-21]].join ' '
  else
    words[n-1]
  end
end

def minutes n
  if n == 1 then 'minute' else 'minutes' end
end

{
  1 => "one",
  13 => "thirteen",
  25 => "twenty five",
  26 => "twenty six",
  29 => "twenty nine",
}.each do |input, output|
  result = int_as_word input
  if result == output
    puts "pass"
  else
    puts "fail given #{input} expected #{output} got #{result}"
  end
end

{
  [3, 00] => "three o'clock",
  [5, 47] => "thirteen minutes to six",
  [5, 0] => "five o'clock",
  [5, 1] => "one minute past five",
  [5, 10] => "ten minutes past five",
  [5, 15] => "quarter past five",
  [5, 30] => "half past five",
  [5, 40] => "twenty minutes to six",
  [5, 45] => "quarter to six",
  [5, 28] => "twenty eight minutes past five",
  [12, 0] => "twelve o'clock",
}.each do |(hours, minutes), output|
  result = time_in_words hours, minutes
  if result == output
    puts "pass"
  else
    puts "fail given #{[hours, minutes]} expected #{output} got #{result}"
  end
end
