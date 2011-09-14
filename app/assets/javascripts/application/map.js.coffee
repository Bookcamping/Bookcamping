
$.fn.mapper = (options) ->
  @defaultOptions = {}
  settings = $.extend({}, this.defaultOptions, options);
  this.each ->
