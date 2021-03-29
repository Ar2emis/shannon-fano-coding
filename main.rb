require 'yaml'
require_relative 'lib/shannon_fano'

INPUT_FILE = 'input.yml'.freeze
OUTPUT_FILE = 'output.yml'.freeze

input = YAML.safe_load(File.open(INPUT_FILE))['input']

shannon_fano = ShannonFano.encode(input)
File.open(INPUT_FILE, 'w') { |file| file.write(shannon_fano.transform_keys(&:to_s).to_yaml) }

decoded_row = ShannonFano.decode(shannon_fano[:output], shannon_fano[:tree])
File.open(OUTPUT_FILE, 'w') { |file| file.write({ 'output' => decoded_row }.to_yaml) }
