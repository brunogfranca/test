class Monopoly
  game_finished: false
  output: ''
  player_position: 0
  
  constructor: () ->
    @board = new Board()
    @player = new Player 500

  turn: () ->
    return @output if @game_finished
    @output += '<br/>'+ 'Rolling dices'
    [a, b] = @roll_dices 2
    # calculate the walking distance
    walking_distance = a+b
    @output += '<br/>'+ 'You got a '+a+' and a '+b
    # walks
    @walk walking_distance
    # check what happens
    @check_square_action walking_distance
    @output += '<br/>'+ 'Your current balance is '+@player.cash if not @game_finished
    @output += '<hr />'
    $('#messages').html @output
    $('#cash').html 'Cash: '+@player.cash
    $('.board tr td').each () ->
      $(@).removeClass 'player_square'
    $('#square_'+@player_position).addClass 'player_square'
    @output = ''
    #@turn()


  roll_dice: () ->
    # return a random number from 1 to 6
    return Math.floor((Math.random()*6))+1

  roll_dices: (num) ->
    # return a set of roll_dice
    return [@roll_dice(),@roll_dice()]

  walk: (distance) ->
    if (@player_position + distance + 1) > (@board.square_set.length)
      @player_position = (@player_position + distance) - (@board.square_set.length - 1)
      @output += '<br/>'+ 'Congratulation! You just passed through GO! Here`s your $200!'
      @player.cash += 200
    else
      @player_position += distance

  check_square_action: (roll) ->
    @output += '<br/>'+ @player_position
    square_type = @board.square_set[@player_position].type
    switch square_type
      when 'rent'
        @output += '<br/>'+ "That's too bad! You have to pay "+30*roll+" for the rent."
        @player.cash -= 30*roll
      when 'utility'
        @output += '<br/>'+ "That's too bad! You have to pay "+20*roll+" for the utility."
        @player.cash -= 20*roll
    if @player.cash <= 0
      @output += '<br/>'+ 'Sorry, you just ran out of money. Better luck next time.'
      @game_finished = true

  run: () ->
    @output += '<h1>Starting the game!</h1>'
    @turn()


class Player
  constructor: (@cash) ->


class Board
  @square_set: null
  constructor: () ->
    @square_set = [
      new Square 'go'
      new Square 'rent'
      new Square 'utility'
      new Square 'utility'
      new Square 'rent'
      new Square 'utility'
      new Square 'rent'
      new Square 'rent'
      new Square 'rent'
      new Square 'utility'
      new Square 'utility'
      new Square 'rent'
      new Square 'utility'
      new Square 'rent'
      new Square 'rent'
      new Square 'utility'
    ]

class Square
  constructor: (@type) ->

game = {}
$(document).ready () ->
  game = new Monopoly()
  $('#new_game').click () ->
    console.log 'New Game'
    game = new Monopoly()
    $('#messages').html ''
    $('#cash').html 'Cash: '+game.player.cash
    $('.board tr td').each () ->
      $(@).removeClass 'player_square'
    $('#square_0').addClass 'player_square'
  $('#roll_dice').click () ->
    console.log 'Roll Dice'
    game.turn()
    console.log game.output