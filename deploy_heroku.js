by Heroku CLI
$ heroku login
//Clone the repository
$ git init
$ heroku git:remote -a pangram-of-the-day
//Deploy your changes
$ git add .
$ git commit -am "make it better"
$ git push heroku master