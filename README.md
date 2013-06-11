TwitterStockMood
==================

A web app to analyze the mood of tweets. Tweets are filtered by keywords and compared to the stock market development of certain companies. The web app is built with Ruby on Rails.

Mood analysis
-------------

The mood analysis is done with [AFINN](http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010), a dictionary of English words.

Stock quotes
-------------

Source of the stock quotes is [Yahoo! Finance](http://finance.yahoo.com) with the [yahoofinance](https://rubygems.org/gems/yahoofinance) gem.

Installation
------------

Just download the code, create the [config/database.yml](http://guides.rubyonrails.org/getting_started.html#configuring-a-database) file to connect to a database and run the project with `rails server`. Then you have to setup some twitter streams under *Streams*. Therefore you will need OAuth keys and access tokens, you can get them by creating an app on https://dev.twitter.com. Start a stream by clicking on the *Start process* button.
