require 'prime'

class Raindrops
  def self.convert(number)
    prime_arr = number.prime_division.map {|pair| pair[0].to_s}.uniq
    output = ''
    output_map.each {|k,v| output = "#{output}#{v}" if prime_arr.include?(k)}
    output = number.to_s if output == ''
    output
  end

  private

  def self.output_map
    {
      '3' => 'Pling',
      '5' => 'Plang',
      '7' => 'Plong'
    }
  end

end