#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
 eval "$(jq -r '@sh "WORKER_SCRIPT_PATH=\(.worker_script_path)"')"

pnpm install > /dev/null
pnpm run build > /dev/null

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg worker_script_path "$WORKER_SCRIPT_PATH" '{"worker_script_path":$worker_script_path}'
