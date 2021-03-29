module Encodable
  ZERO = '0'.freeze
  ONE = '1'.freeze

  def encode(row)
    chars_counts = row.chars.group_by(&:itself).transform_values(&:count)
    tree = build_tree(chars_counts.sort_by(&:last).reverse, row.length)
    { tree: tree, input: row, output: encoded_string(row, tree) }
  end

  private

  def encoded_string(row, tree)
    char_bits = char_bits(tree)
    row.chars.map { |char| char_bits[char] }.join
  end

  def build_tree(chars_counts, total)
    return chars_counts.dig(0, 0) if chars_counts.count == 1

    chars_counts.count == 2 ? build_node(chars_counts.dig(0, 0), chars_counts.dig(1, 0)) : split(chars_counts, total)
  end

  def build_node(left_value, right_value)
    { ZERO => left_value, ONE => right_value }
  end

  def split(chars_counts, total)
    weights = weights(chars_counts)
    half_index = weights.index(weights.min_by { |weight| (total.to_f / 2 - weight).abs })
    build_node(build_tree(chars_counts[0..half_index], weights[half_index]),
               build_tree(chars_counts[half_index + 1..-1], total - weights[half_index]))
  end

  def weights(chars_counts)
    Array.new(chars_counts.count) { |index| chars_counts[0..index].sum(&:last) }
  end

  def char_bits(node, bits = '')
    return {}.merge(char_bits(node[ZERO], bits + ZERO)).merge(char_bits(node[ONE], bits + ONE)) if node.is_a?(Hash)

    node.is_a?(String) ? { node => bits } : {}
  end
end
