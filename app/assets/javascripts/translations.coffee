# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.auto-save').each () ->
    $this = $ @
    $this.data 'oldVal', $this.val()

    $this.on 'propertychange change click keyup input paste', (e) ->
      if $this.data('oldVal') != $this.val()
        $this.data 'oldVal', $this.val()

        unless $this.hasClass 'changed'
          $this.addClass 'changed'
          # some styling
          $this.parent().removeClass 'has-success'
          $this.parent().addClass 'has-warning'
          $this.next().removeClass 'glyphicon-ok'
          $this.next().addClass 'glyphicon-flash'


    $this.on 'blur', (e) ->
      if $this.hasClass 'changed'
        # some styling
        $this.next().removeClass 'glyphicon-flash'
        $this.next().addClass 'glyphicon-upload'

        data = $this.data()

        translation = 
          title: $this.val()
          language_id: data.language
          term_id: data.term
          id: data.id

        url = "/projects/#{data.project}/languages/#{data.language}/translations.json"
        method = "POST"

        if data.id
          url = "/projects/#{data.project}/languages/#{data.language}/translations/#{data.id}.json"
          method = "PUT"


        $.ajax
          type: method
          url: url
          data: 
            translation: translation
          success: (data) ->
            # some styling
            $this.parent().removeClass 'has-warning'
            $this.parent().addClass 'has-success'
            $this.next().removeClass 'glyphicon-upload'
            $this.next().addClass 'glyphicon-ok'
          error: (data) ->
            alert 'error'

