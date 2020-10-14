App.progress = App.cable.subscriptions.create "ProgressChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('I got new data', data)
    total_sum = Object.values(data).reduce((a, b) => a + b);
    $('#to_do').css('width', data['to do']/total_sum * 100+'%');
    $('#in_progress').css('width', data['in progress']/total_sum * 100+'%');
    $('#in_review').css('width', data['in review']/total_sum * 100+'%');
    $('#done').css('width', data['done']/total_sum * 100+'%');
