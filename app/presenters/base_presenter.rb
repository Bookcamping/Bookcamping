class BasePresenter
  def initialize(object, options, template)
    @object = object
    @options = options
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def h
    @template
  end
end
