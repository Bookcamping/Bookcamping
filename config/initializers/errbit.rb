if defined?(HoptoadNotifier)
  HoptoadNotifier.configure do |config|
    config.api_key     = 'b32f5945dac5b4b66e3ae4c78c796f24'
    config.host        = 'errcamping.herokuapp.com'
    config.port        = 80
    config.secure      = config.port == 443
  end
end
