$(document).ready(function(){

  $('#next').hide()

  var question = JSON.parse($('[data-question]').text())
  var answers = JSON.parse($('[data-answers]').text())

  var $gameForm = $('#game-form')

  // $gameForm.on('submit', function(event){
  $('.game-button').on('click', function(event){
    event.preventDefault()

    // var userChoice = $gameForm.find('[name=user_choice]:checked').val()
    var userChoice = $(this).val()

    var data = { question: question, choices: answers, user_choice: userChoice }

    $.ajax({
      type: "POST",
      url: '/evaluate_question',
      contentType: 'application/json',
      data: JSON.stringify(data),
      success: function(response){
        $('#results').html(response.result + '!<br><br>' + response.question  + ' :<br>' + response.correct )
        $('#next').show()
      }
    })

  })

})
