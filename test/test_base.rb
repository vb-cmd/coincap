# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require './lib/coincap'
require 'minitest/autorun'

class TestBase < Minitest::Test
end