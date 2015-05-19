Template.iouNew.helpers
  users: ->
    if Session.get('suite')?
      Suites.findOne(Session.get('suite')._id).users

  getUserName: (id) ->
    usr = Meteor.users.findOne id
    if usr.profile?
      userName = usr.profile.first_name + " " + usr.profile.last_name

Template.iouNew.events
  'submit form': (e) ->
    e.preventDefault()
    payer = $(e.target).find('[name=payer]').val()
    payee = $(e.target).find('[name=payee]').val()

    iou =
      payerId:    payer
      payeeId:    payee
      reason:     $(e.target).find('[name=reason]').val()
      amount:     $(e.target).find('[name=amount]').val()
      paid:       false

    Meteor.call 'newIou', iou, (error, id) ->
      if error
        return alert(error.reason)
      $('#newIouModal').modal('toggle')
      $('#newIouModal').find('input:text').val('')
      Router.go '/'
      return

    return