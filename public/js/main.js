$(document).ready(function(){

  $('#next').hide()

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
        $('#results').html(response.result + '!<br><br>' + response.question  + '<br>' + response.correct )
        $('#next').show()
      }
    })

  })
  // update the question when user clicks "Next"
  $('.container').on('click', '#next',function(event){
    event.preventDefault()
    $.get('/', function(response){
      $('.container').html(response)
      $('#next').hide()
    })

  })

})
