import os
import slack
import slack.chat
from aiosmtpd.handlers import Message

slack.api_token = os.getenv('SLACK_TOKEN', '')
channel = os.getenv('SLACK_CHANNEL', '#general')
username = os.getenv('SLACK_USERNAME', 'monit')
icon_url = os.getenv('SLACK_ICON_URL', 'https://bitbucket.org/tildeslash/monit/avatar/128')

class MessageHandler(Message):
    def handle_message(self, message):
        txt = message.get_payload()
        print('Sending to {} message:\n{}'.format(message['X-RcptTos'], txt))
        slack.chat.post_message(channel, txt + ' | ' + repr(message) + ' | ' + str(message), username=username, icon_url=icon_url)
