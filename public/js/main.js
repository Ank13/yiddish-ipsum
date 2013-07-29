$(document).ready(function(){

  $('#next').hide()

  var question = JSON.parse($('[data-question]').text())
  var answers = JSON.parse($('[data-answers]').text())

  var $gameForm = $('#game-form')

  $gameForm.on('submit', function(event){
    event.preventDefault()

    var userChoice = $gameForm.find('[name=user_choice]:checked').val()

    var data = { question: question, choices: answers, user_choice: userChoice }

    console.log(data)

    $.ajax({
      type: "POST",
      url: '/evaluate_question',
      contentType: 'application/json',
      data: JSON.stringify(data),
      success: function(response){
        $('.container').append(response.result + '!  <br>' + response.correct + '<br>is<br>' + response.question)
        $('#next').show()
      }
    })

  })

})
