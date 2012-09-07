express = require 'express'
Monopoly = require './monopoly/monopoly'
static_files = require './static'
app = express()

app.set 'view engine', 'jade'
app.set 'views', './'

app.get '/', (req, res) ->
	monopoly = new Monopoly()
	res.send monopoly.run()

app.get '/playable', (req, res) ->
	res.render 'playable', 
    title: 'Playable'
    cash: 500

app.listen 4000
console.log 'Listening on port 4000'
