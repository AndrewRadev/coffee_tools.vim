db.query "select * from users", (err, users) ->
    db.query "select * from posts", (err, posts) ->
    db.query "select * from comments", (err, comments) ->
      console.log [users, comments]
      console.log [users, posts]
  something
  something_else
