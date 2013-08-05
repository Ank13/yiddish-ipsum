$(document).ready(function(){

  // get their current score
  var answeredCorrect = parseInt($('[data-answered-correct]').text())

  // evaluate user choice when they click an answer button
  $('.container').on('click', '.game-button' ,function(event){
    event.preventDefault()

    var question = JSON.parse($('[data-question]').text())
    var answers = JSON.parse($('[data-answers]').text())

    // var userChoice = $gameForm.find('[name=user_choice]:checked').val()
    var userChoice = $(this).val()

    var data = { question: question, choices: answers, user_choice: userChoice }

    $.ajax({
      type: "POST",
      url: '/evaluate_question',
      contentType: 'application/json',
      data: JSON.stringify(data),
      success: function(response){
        $('#results').html(response.result + '!  The translation was:<br><br>' + response.question  + '<br>' + response.correct )
        $('#next').show()

        // if they answered correctly, increase score by 1
        if (response.result === 'Correct') {
          answeredCorrect += 1
          $('[data-answered-correct]').text(answeredCorrect)
        }

        // load next question
        $.get('/question', function(response){
          $('.container').html(response)
        })

      }
    })

  })

})
