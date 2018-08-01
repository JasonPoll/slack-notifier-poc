#!/usr/bin/env ruby

require 'bundler/inline'

puts "Verifying inline-gemfile gems are installed...hold on."
gemfile do
  source 'https://rubygems.org'
  gem 'slack-notifier'
end

HOOK_URL=ENV['SLACK_HOOK_URL']
raise 'you must specify SLACK_HOOK_URL as an environment variable' if HOOK_URL.empty? || HOOK_URL.nil?
puts "Attempting to send a message to slack via webhook '#{HOOK_URL}'"

notifier = Slack::Notifier.new(HOOK_URL) do
  defaults channel: "#pods-notifications",
           username: "jtp-notifier"
end

notifier.ping "Basic vanilla test message"
notifier.ping "<!channel> Noisy 'notify everyone' test message"

# for any messages with HTML formatting, you need to escape that shiz.  Anything that's got '<' or '>', basically. 
link_text = Slack::Notifier::Util::Escape.html("User <user@example.com>")
# and why don't we use that in a markdown styled message? 
message = "Message with special characters and a little markdown syntax: [#{link_text}](mailto:user@example.com)"
notifier.ping(message)

# 'ping' has been a quick-n-dirty helper method.  If you want to do more stuff, you have to use #post.
# note: you can specify 'channel:' with #post, although I'm not here.
# UPDATE: That's complete shit...it appears that you can specify 'icon_url' for #ping as well...
notifier.post text: 'yis?', icon_url: "http://static.mailchimp.com/web/favicon.png"

# with an 'attachment'(...not a file attachment)
a_ok_note = {
  fallback: "Everything looks peachy",
  text: "Everything looks peachy",
  color: "good"
}
notifier.post text: "with an attachment", attachments: [a_ok_note]

# crazy note...there will be inteactive elements in the message 'attachment'...but they
# won't actually do anything...
crazy_note = {
  fallback: "Plan a vacation",
  author_name: "Owner: rdesoto",
  title: "Plan a vacation",
  text: "I've been working too hard, it's time for a break.",
  actions: [
    {
      name: "action",
      type: "button",
      text: "Complete this task",
      style: "",
      value: "complete"
    },
    {
      name: "tags_list",
      type: "select",
      text: "Add a tag...",
      data_source: "static",
      options: [
        {
          text: "Launch Blocking",
          value: "launch-blocking"
        },
        {
          text: "Enhancement",
          value: "enhancement"
        },
        {
          text: "Bug",
          value: "bug"
        }
      ]
    }
  ]
}
notifier.post text: "with a crazy attachment", attachments: [crazy_note]

munky_notifier = Slack::Notifier.new(HOOK_URL) do
  defaults channel: "#pods-notifications",
           username: "munky",
           icon_url: "http://static.mailchimp.com/web/favicon.png"
end

