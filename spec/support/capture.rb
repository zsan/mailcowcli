# module MyCapture
#   def capture()
#     $stdout = StringIO.new
#     yield
#     $stdout.string
#   ensure
#     $stdout = STDOUT
#   end
# end

# RSpec.configure do |config|
#   config.include MyCapture
# end