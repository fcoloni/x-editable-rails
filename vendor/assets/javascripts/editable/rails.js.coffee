jQuery ($) ->
  EditableForm = $.fn.editableform.Constructor
  EditableForm.prototype.saveWithUrlHook = (value) ->
    url = @options.url
    model = @options.model
    nestedName = @options.nested
    nestedId =  @options.nid
    nestedLocale = @options.locale
    @options.url = (params) =>
      myName = params.name
      myValue = params.value.replace(/(\r\n|\n|\r)/gm,"<br/>")
      obj = {}
      if nestedName
        nested = {}
        nested[myName] = myValue
        nested['id'] = nestedId
        if nestedLocale
          nested['locale'] = nestedLocale
        obj[nestedName + '_attributes'] = nested
      else
        obj[myName] = myValue
      params[model] = obj
      delete params.name
      delete params.value
      delete params.pk
      $.ajax($.extend({
      url     : url
      data    : params
      type    : 'PUT'
      dataType: 'json'
      }, @options.ajaxOptions))
    @saveWithoutUrlHook(value)
  EditableForm.prototype.saveWithoutUrlHook = EditableForm.prototype.save
  EditableForm.prototype.save = EditableForm.prototype.saveWithUrlHook