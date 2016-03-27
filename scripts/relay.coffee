# Description:
#   Relay your message to http request
#
# Notes:
#   export RELAY_RESPONSE=true if you want it answer after relay
#   export RELAY_EVERYTHING=true if you want it relay everything
#

module.exports = (robot) ->
  robot.catchAll (msg) ->
    r = new RegExp "^(?:#{robot.alias}|#{robot.name}) ([^]+)", "i"
    matches = msg.message.text.match(r)
    if matches != null && matches.length > 1
      message = matches[1]
    else
      return if !process.env.RELAY_EVERYTHING
      message = msg.message.text

    message = if robot.adapter.removeFormatting then robot.adapter.removeFormatting(message) else message
    msg.send "Relay Error! Please set your RELAY_URL\
      \nEx: export RELAY_URL='http://your_domain_or_ip:8080/hubot/relay'" if !process.env.RELAY_URL

    data = JSON.stringify({msg: message})
    robot.http(process.env.RELAY_URL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if err
          msg.send "Relay failed :(\n #{err}"
        else if process.env.RELAY_RESPONSE
          msg.send "Relay completed '#{message}'"

