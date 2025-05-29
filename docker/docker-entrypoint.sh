#!/usr/bin/env bash
set -e

CONFIG_FILE="${CONFIG_FILE:-/app/emailproxy.config}"

if [ ! -f "$CONFIG_FILE" ]; then
    mv /app/emailproxy.config.tpl /app/emailproxy.config
fi

update_config() {
    local key=$1
    local value=$2
    sed -i "s|^${key}[ ]*=.*|${key} = ${value}|g" "${CONFIG_FILE}"
}

# update a key in a specific TOML section
update_toml_config() {
    local section="$1"
    local key="$2"
    local value="$3"
    local file="$4"

    awk -v section="$section" -v key="$key" -v value="$value" '
    BEGIN { in_section=0; updated=0 }
    /^\[.*\]/ {
        if ($0 == "[" section "]") {
            in_section=1
        } else {
            if (in_section && !updated) {
                print key " = " value
                updated=1
            }
            in_section=0
        }
    }
    {
        if (in_section && $0 ~ "^" key " =") {
            print key " = " value
            updated=1
            next
        }
        print
    }
    END {
        if (!updated) {
            if (!in_section) print "[" section "]"
            print key " = " value
        }
    }
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
}

# Process EMAILPROXY_ env vars for TOML config updates
for var in $(env | grep '^EMAILPROXY_' | cut -d= -f1); do
    rest=${var#EMAILPROXY_}
    section_part=${rest%__*}
    key_part=${rest##*__}
    # Only process if both section and key are present
    if [[ "$section_part" != "$rest" && -n "$key_part" ]]; then
        # Section: _AT_ to @, double underscores to dots, lowercase
        section=$(echo "$section_part" | sed 's/_AT_/@/g; s/__/./g' | tr '[:upper:]' '[:lower:]')
        key=$(echo "$key_part" | tr '[:upper:]' '[:lower:]')
        value="${!var}"
        update_toml_config "$section" "$key" "$value" "$CONFIG_FILE"
    fi
    # If no section, fallback to global update_config
    if [[ "$section_part" == "$rest" ]]; then
        key=$(echo "$rest" | tr '[:upper:]' '[:lower:]')
        value="${!var}"
        update_config "$key" "$value"
    fi
done

ARGS="--config-file $CONFIG_FILE"

if [ "$LOCAL_SERVER_AUTH" = "true" ]; then
    ARGS="$ARGS --local-server-auth"
else
    ARGS="$ARGS --external-auth"
fi

if [ "$DEBUG" = "true" ]; then
    ARGS="$ARGS --debug"
fi

if [ -n "$CACHE_STORE" ]; then
    ARGS="$ARGS --cache-store $CACHE_STORE"
fi

if [ -n "$ARGS" ]; then
    exec "$@" $ARGS
else
    exec "$@"
fi
