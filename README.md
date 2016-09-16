# Slacker

Slacker is simple email-to-slack gateway. It support basic rules for routing
messages to different slack channels from different bots.

Main purpose of slacker is to redirect messages from old-school systems which doesn't
support messaging other than email. For example cron and monit
(https://mmonit.com/monit/) support only emails as the only system for
notifications.

## Installation

Slacker can be easily installed via docker:

```bash
docker pull ontrif/slacker
```

Then run container with custom slacker `config.yml`:

```bash
docker run \
    -d --restart=always \
    --name=slacker \
    -v /path/to/config.yml:/etc/slacker/config.yml \
    -p localhost:8025:8025 \
    ontrif/slacker
```
Last command will start SMTP server on `localhost:8025`

## Config

Slacker supports simple list of rules for configuring target slack channel, bot
name and its avatar depending on email content.

There are two sections:
  * default: this is default options for sending message to slack.
  * rules: list of rules for matching email message against 'from', 'to' and/or 'subject'.

Each rule in list tested in order. First matched rule is used to update
options values from 'default' section of config.

Example `config.yml` for redirecting email to two channels: `#monit` and `#cron`:
```yaml
# default values for channel, bot name, avatar url, slack token and debug mode
default:
    channel: '#general'
    username: slacker
    icon_url: ''
    slack_token: xoxb-00000000000-aaaaaaaaaaaaaaaaaaaaaaaa
    debug: false


# list of rules
rules:
    - name: Monit rule
      from: monit@.*     # all emails from monit@localhost will match this rule

      options:
          username: monit
          channel: '#monit'
          icon_url: 'https://bitbucket.org/tildeslash/monit/avatar/128'
          debug: false


    - name: Cron rule
      from: root@localhost
      subject: Cron.*    # cron email subject starts with "Cron..."

      options:
          username: cron
          channel: '#cron'
          icon_url: ''
          debug: true    # will output full email with all X-headers
```
