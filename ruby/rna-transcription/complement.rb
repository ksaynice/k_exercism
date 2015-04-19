class Complement
  def self.of_dna(nucleotide)
    nucleotide.each_char.map do |char|
      raise ArgumentError unless nucleotides_map.include?(char)
      nucleotides_map[char]
    end.join('')
  end

  def self.of_rna(nucleotide)
    nucleotide.each_char.map do |char|
      raise ArgumentError unless nucleotides_map.invert.include?(char)
      nucleotides_map.invert[char]
    end.join('')
  end

  private

  def self.nucleotides_map
    {
      'G' => 'C',
      'C' => 'G',
      'T' => 'A',
      'A' => 'U'
    }
  end
end