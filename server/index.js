// Imports
const express = require('express');
const app = express();
var Raven = require('raven');

// When the server is launch with the bash script, we can add the DSN manually, 
// if its not defined, we use a default one 
var arg = process.argv.slice(2)[0];
if(arg === undefined || arg === "" || arg === null){
	arg = 'https://982404c7f0ea48e8827ab908ec4dc583:5c41cb0ec8fd4298b6adb82059a83e62@sentry.io/256051';
}
// Must configure Raven before doing anything else with it
Raven.config(arg).install();
// The request handler must be the first middleware on the app
app.use(Raven.requestHandler());
// The error handler must be before any other error middleware
app.use(Raven.errorHandler());


// Create server listening to port 3000
var server = app.listen(3000, function () {
  Raven.captureMessage("Server PingCount started at " + new Date());
  console.log('Server is running')
})

// Variable that will be return on get '/count' request
var count = 0;

// REST URLs
app.get('/', function (req, res) {
  res.send('Hello from the other side !');
})

app.get('/ping', function (req, res) {
  count++;
  res.send(JSON.stringify({message:'pong'}));
})

app.get('/count', function (req, res) {
  res.send(JSON.stringify({pingCount:count}))
})

// 404
app.get('*', function(req, res){
	res.statusCode = 404;
	res.redirect('/');
})

//When error is detected 
app.use(function onError(err, req, res, next){
	res.statusCode = 500;
	res.end(res.sentry + '\n');
})

//On ctrl+c
process.on('SIGINT', function(){	
	Raven.captureMessage("Server PingCount ended at " + new Date(), function(){
		// After message logged to sentry (promise)
		console.log("\nServer shuts down");
		server.close();
		process.exit();
	});
})
