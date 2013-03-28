express = require "express"
routes = require "./routes"
http = require "http"
path = require "path"
hbs = require 'hbs'
gzip = require 'connect-gzip'
app = express()
app.configure ->

  app.set "port", process.env.PORT or 3000
  app.set "views", "#{__dirname}/public/template"
  app.set "view engine", "hbs"
  app.set "view cache", true
  app.set "view options",
    layout: "layout"
  app.use gzip.gzip
    flags: '--best'
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use app.router
  app.use gzip.staticGzip(path.join(__dirname, "public"), {maxAge: 86400000, flags: "--best"})

app.configure "development", ->
  app.use express.errorHandler()

app.get "/infos", routes.infos
app.get "/", routes.index

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
