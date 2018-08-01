# Hi
This is just some messing around with the [slack-notifier gem](https://github.com/stevenosloan/slack-notifier). Nothing really to see here. 

# Notes to self: 

1. Make sure you've got rvm/rbenv strapped in.
1. Have slack
1. Have a slack channel
1. Add _Incoming Webhooks_ 'app' to your channel ( https://slack.com/apps/A0F7XDUAZ-incoming-webhooks ) if you don't already have one setup...
  * Configure to point to your desired channel.
    * Doesn't really matter what the channel is - the [slack-notifier gem](https://github.com/stevenosloan/slack-notifier) can send to other rooms as well, not _just_ the one you've configured.
  * Note the webhook URL for later use.
1. See test/example scripts for quick-n-dirty example usage.
  * Test scripts probably have an [inline gemfile](https://gist.github.com/chrisroos/0ddf618ac711abe0f465), and if you have trouble running them, you may need to run them like:
    ``` shell
    BUNDLE_IGNORE_CONFIG=true ./test-script.rb
    ```
  * You'll need to also export your slack hook URL into the shell environment before executing a script.  So like, in your `~/.bashrc` :
    ``` shell
    export SLACK_HOOK_URL='https://hooks.slack.com/services/UR/HOOK/URL/NO/RLY/REPLACE/THIS/WHOLE/THING'
    ```
    Or just fire up the script like: 
    ``` shell
    SLACK_HOOK_URL='https://hooks.slack.com/services/UR/HOOK/URL/NO/RLY/REPLACE/THIS/WHOLE/THING' ./test-script.rb
    ``` 

