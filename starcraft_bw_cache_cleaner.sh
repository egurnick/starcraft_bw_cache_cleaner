#!/bin/bash

CACHE_DIR="/Users/Shared/Battle.net/Agent/data/cache"
PROCESS_NAME="StarCraft"

# Exit immediately if StarCraft isn't running
if ! pgrep -f "$PROCESS_NAME" >/dev/null; then
    exit 0
fi

# Only delete if directory exists and is non-empty
if [ -d "$CACHE_DIR" ] && [ "$(ls -A "$CACHE_DIR")" ]; then
    rm -rf "$CACHE_DIR"/*
fi
