#!/usr/bin/env bash

# set -euo pipefail

JELLYFIN_URL="http://192.168.68.67:8096"

JELLYFIN_USER_ID="3bf0992a73f24b619637b4ba62503439"

JELLYFIN_TOKEN="$(<"$HOME/.config/jellyfin/api-key")"

AUTH_HEADER="Authorization: MediaBrowser Token=\"$JELLYFIN_TOKEN\""

SESSIONS="$(
  curl \
    --silent \
    --show-error \
    --fail \
    --header "$AUTH_HEADER"\
    --get \
    --data-urlencode "activeWithinSeconds=30"\
    "$JELLYFIN_URL/Sessions"
)"

ITEM_ID="$(
    jq \
        --raw-output \
        '
            [
                .[]
                | select(.NowPlayingItem.MediaType == "Audio")
                | select(.PlayState.IsPaused == false)
            ]
            | sort_by(.LastActivityDate)
            | last
            | .NowPlayingItem.Id // empty
        ' \
        <<<"$SESSIONS"
)"

ITEM_NAME="$(
    jq \
        --raw-output \
        '
            [
                .[]
                | select(.NowPlayingItem.MediaType == "Audio")
                | select(.PlayState.IsPaused == false)
            ]
            | sort_by(.LastActivityDate)
            | last
            | .NowPlayingItem.Name // empty
        ' \
        <<<"$SESSIONS"
)"

if [[ -z "$ITEM_ID" ]]; then
  notify-send "Jellyfin" "No current track found"
  exit 1
fi
