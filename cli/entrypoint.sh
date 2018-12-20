#!/bin/sh

set -e

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

for cmd in "$@"; do
    echo "Running 'aws $cmd'..."
    if sh -c "aws $cmd"; then
        # no op
        echo "Successfully ran 'aws $cmd'"
    else
        exit_code=$?
        echo "Failure running 'aws $cmd', exited with $exit_code"
        exit $exit_code
    fi
done
