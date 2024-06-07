#!/bin/zsh

PROFILE_FILE="$HOME/.docker_profiles.json"
CURRENT_PROFILE_FILE="$HOME/.current_docker_profile"

if [[ ! -f "$PROFILE_FILE" ]]; then
    echo '[]' > "$PROFILE_FILE"
fi

function dx-add() {
    read "username?Docker Username: "
    read "password?Docker Password: "
    read "server?Docker Server (default: https://index.docker.io/v1/): "
    server=${server:-https://index.docker.io/v1/}

    jq ". += [{\"username\": \"$username\", \"password\": \"$password\", \"server\": \"$server\"}]" "$PROFILE_FILE" > "$PROFILE_FILE.tmp" && mv "$PROFILE_FILE.tmp" "$PROFILE_FILE"
    echo "Profile added."
}

function dx-remove() {
    profiles=$(jq -r '.[] | "\(.username) \(.server)"' "$PROFILE_FILE")
    selected=$(echo "$profiles" | fzf --header="Select profile to remove")

    if [[ -n "$selected" ]]; then
        username=$(echo "$selected" | awk '{print $1}')
        jq "del(.[] | select(.username == \"$username\"))" "$PROFILE_FILE" > "$PROFILE_FILE.tmp" && mv "$PROFILE_FILE.tmp" "$PROFILE_FILE"
        echo "Profile removed."
    fi
}

function dx() {
    if [[ -z "$1" ]]; then
        if [[ -f "$CURRENT_PROFILE_FILE" ]]; then
            current_profile=$(cat "$CURRENT_PROFILE_FILE")
            echo "Current profile logged in: $current_profile"
        else
            echo "No profile is currently logged in."
        fi
    else
        profile_name="$1"
        profile=$(jq -r ".[] | select(.username == \"$profile_name\")" "$PROFILE_FILE")

        if [[ -n "$profile" ]]; then
            username=$(echo "$profile" | jq -r '.username')
            password=$(echo "$profile" | jq -r '.password')
            server=$(echo "$profile" | jq -r '.server')

            docker logout
            echo "$password" | docker login -u "$username" --password-stdin "$server"
            echo "$username" > "$CURRENT_PROFILE_FILE"
            echo "Logged in as $username."
        else
            echo "Profile not found: $profile_name"
        fi
    fi
}

function _dx_complete() {
    local profiles=$(jq -r '.[].username' "$PROFILE_FILE")
    _arguments "*:: :($profiles)"
}

compdef _dx_complete dx
compdef dx-add dx-remove
