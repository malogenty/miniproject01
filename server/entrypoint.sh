#!/bin/sh
# Docker entrypoint script.

# Sets up tables and running migrations.
/app/bin/miniproject01 eval "ApiProject.Release.migrate"
/app/bin/miniproject01 eval "ApiProject.Seeder.insert_all"

# Start our app
/app/bin/server