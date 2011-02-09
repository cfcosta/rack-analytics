#!/usr/bin/env ruby

watch( 'test/.*_test\.rb' )  {|md| system("rake test") }
watch( 'lib/.*\.rb' )  {|md| system("rake test") }
