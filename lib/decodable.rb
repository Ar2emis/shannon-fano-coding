module Decodable
  def decode(row, tree)
    decoded_row = ''
    row.chars.inject(tree) do |node, char|
      next node[char] if node.is_a?(Hash)

      decoded_row += node
      tree[char]
    end
    decoded_row
  end
end
