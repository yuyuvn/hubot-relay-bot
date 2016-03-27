# Description:
#   Relay your message to http request
#
# Notes:
#   export RELAY_RESPONSE=true if you want it answer after relay
#

module.exports = (robot) ->

  robot.respond /$.+^/, (msg) ->
    msg.send "Relay Error! Please set your RELAY_URL\
      \nEx: export RELAY_URL='http://your_domain_or_ip:8080/hubot/relay'" if !process.env.RELAY_URL
    data = JSON.stringify({msg: msg.match[0]})
    robot.http(process.env.RELAY_URL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if err
          msg.send "Relay failed :(\n #{err}"
        else if process.env.RELAY_RESPONSE
          msg.send "Relay completed"

