express = require 'express'
Monopoly = require './monopoly/monopoly'
app = express()

app.get '/', (req, res) ->
	monopoly = new Monopoly()
	res.send monopoly.run()

app.listen 4000
console.log 'Listening on port 4000'
