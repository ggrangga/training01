by Heroku CLI
$ heroku login
//Clone the repository
$ heroku git:clone -a pangram-of-the-day
$ cd pangram-of-the-day
//Deploy your changes
$ git add .
$ git commit -am "make it better"
$ git push heroku master