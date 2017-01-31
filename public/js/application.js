$(document).ready(function() {
  $('#enabledInput').focus()
  console.log('why')
  $(document).on('submit', '#url', function(e) {
    e.preventDefault()
    var data = $(this).serialize()
    var request = $.ajax({
      url: '/urls',
      type: 'post',
      data: data
    })
    request.done(function(data) {
      $('input.input-lg').popover('destroy')
      $('#temprow').show()
      $('.table > tbody > tr:nth-child(2)').before(data)
      document.getElementById('url').reset()
    })
    request.fail(function(msg) {
      $('[data-toggle="popover"]').popover()
      $('input.input-lg').popover('show')
    })
  })
  $(document).on('click', 'td a', function(e) {
    var urlId = e.target.id
    var url = '/cc/' + urlId + ''
    var updateClickCount = $.ajax({
      url: url,
      type: 'get'
    })
    updateClickCount.done(function(data) {
      $('td[short-url=' + urlId + ']').text(data.click_count + 1  )
      console.log('[successful] click count: ' + data.click_count)
      console.log($('td[short-url=' + urlId + ']').text())
    })
    updateClickCount.fail(function() {
      console.log("fail")
    })
  })
});
