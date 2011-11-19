class BasePresenter
  def initialize(object, options, template)
    @object = object
    @options = options
    @template = template
  end

  def[](name)
    @options[name]
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def h
    @template
  end

  def render(name, model)
    #klazz = "#{name.to_s.camelcase}Presenter".constantize

  end
end
