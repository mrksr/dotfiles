#!/bin/bash
# This is a simple script which uses notmuch and the standard 'notify-send'
# utility to create notification popups with email subjects.
# Due to the way notify-send handles special characters you will also need
# the recode utility to change from UTF-8 to HTML.

# Most of the settings are set below.

# USAGE:
#   notmuch-notification.sh [--show-none]
#
#   --show-none  show a notification even if there are no new messages.

# See https://github.com/natmey/dotfiles/blob/master/notmuch/notmuch-notification.sh


# The notmuch search that will generate subjects you want
SEARCH="tag:new and tag:unread and tag:inbox"

# set some other things you might want to change

# The number of subjects to show in the notification
#   corresponds to the --limit option of notmuch search
LIMIT=5

# the icon in the notification window
NOTIFICATION_ICON='/usr/share/icons/Adwaita/256x256/emblems/emblem-mail.png'

# the sort order of subjects
#   corresponds to the --sort option of notmuch search
SORT="newest-first"

# have notmuch count the number of messages in the search
UNREAD_COUNT=$(notmuch count --output=messages "$SEARCH")
if [ "$UNREAD_COUNT" -gt 0 ]; then
  # have notmuch pull the specified number of mail subjects from the search.
  # also, do some rought formatting of the result, to pull thread string,
  # sender etc. leaving just the subject text.
  TXT_SUBS=$(notmuch search --format=text --output=summary --limit="$LIMIT" --sort="$SORT" "$SEARCH" | sed 's/^[^;]*; //' | sed 's/$/\n'/)

  notify-send -i "$NOTIFICATION_ICON" "$UNREAD_COUNT unread mesages." "$TXT_SUBS"
elif [ -z "$1" ]; then
  exit 0
elif [ "$1" == "--show-none" ]; then
  notify-send -i "$NOTIFICATION_ICON" "No unread messages."
fi

exit 0
