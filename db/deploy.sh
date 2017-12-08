#!/bin/bash

psql -U postgres -f drop.sql -v database=wal
psql -U postgres -f install.sql -v database=wal
