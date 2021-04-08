# frozen_string_literal: true

module Decodable
  DECODED_SUFFIX = '.decoded'

  def decode_file(file_name)
    decoded_row = decode(File.open(file_name).read)
    File.open(file_name + DECODED_SUFFIX, 'w') { |file| file.write(decoded_row) }
  end

  def decode(row)
    stream = StringIO.new(row)
    info = eval(stream.readline)
    decoded_row = ''
    prepared_row(stream.read, info).chars.inject(info[:tree]) do |node, char|
      next node[char] if node.is_a?(Hash)

      decoded_row += node
      info[:tree][char]
    end
    decoded_row
  end

  private

  def prepared_row(row, info)
    row.unpack1('B*')[0..-info[:trash_count]]
  end
end
