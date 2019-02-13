# Tweeter command line client

### Read from $STDIN and send to twitter as tweet or tweets in a thread

### Install

* Make sure you have Ruby installed. Version 2.5 or higher.
* `cd` into directory and run `$ bundle install`
* Make the script executable to not have to run it with ruby explicitly: `$ chmod 755 main.rb`
* Create your .env file with your Twitter API keys
  * `$ cp .env_copy .env`
  * You can get Twitter API keys here:[https://developer.twitter.com](https://developer.twitter.com/)
* Add the script to your path if you want to call it from anywhere on your system.

### Use

The scripts reads from $STDIN and then processes the input to either send one invidual or multiple tweets connected in a thread.
There are different ways to pipe input into the script. It's possible to `$ echo` something directly from the command line. 
Also a file can be printed out and then piped into the script. Thanks to Ruby's `ARGF` it's also possible to pass the filename as a command line argument:

  * ./main.rb text.md
  * cat text.md | ./main.rb
  * echo "hello twitter" | ./main.rb


