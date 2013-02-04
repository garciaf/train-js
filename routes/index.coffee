station = require "#{__dirname}/../data/station.json"
request = require 'request'

#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "index",
    title: "TrainJs"

exports.infos = (req, res) ->
  gareCode = req.query.code
  url = "http://sncf.mobi/infotrafic/iphoneapp/ddge/?gare=#{gareCode}"
  request url, (error, response, body) =>
    if error then res.send(500, error)
    res.send body

exports.stations = (req, res) ->
  res.send station