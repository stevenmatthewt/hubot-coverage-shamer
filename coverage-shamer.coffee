# Description:
#   Monitors coverage and yells at people if necessary

module.exports = (robot) ->
  Contacts = (require 'hubot-contacts') robot

  robot.hear /(.*)Changes in this Branch: (.{0,4})% of tested classes covered(.*)/i, (msg) ->
    percentage = parseFloat msg.match[2]

    if percentage? && percentage < 70
      user = (msg.match[1].match /(.*): (.*)'s build(.*)/)[2]

      if user
        userId = Contacts.lookUpId 'githubUsername', user
        if userId
          jid = (robot.brain.userForId userId).jid
          robot.send user: jid, "YOU SUCK! (Ur bad at tests)"
        else
          msg.send "#{user} has not set their Github username! Please set this up to get nice coverage messages."



  
