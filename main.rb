# frozen_string_literal: true

require 'yaml'
require_relative 'lib/shannon_fano'

file_name = ARGV[0]
ShannonFano.encode_file(file_name)
ShannonFano.decode_file(file_name + Encodable::ENCODED_SUFFIX)
