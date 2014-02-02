$ ->
  PrivatePub.subscribe '/lots/update', (data, channel) ->
    console.log(data)
    $('#lot_' + data.lot_id + ' .end_time').html(data.end_time)
