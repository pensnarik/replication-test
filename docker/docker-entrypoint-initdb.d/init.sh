#!/bin/sh

sed -ri "s/#(listen_addresses) = 'localhost'/\1 = '*'/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(wal_level) = .*/\1 = ${PG_WAL_LEVEL:-minimal}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_worker_processes) = .*/\1 = 10/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_replication_slots) = .*/\1 = 100/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_wal_senders) = .*/\1 = ${PG_MAX_WAL_SENDERS:-60}/" "${PGDATA}/postgresql.conf"
sed -ri "s/(max_connections) = .*/\1 = ${PG_MAX_CONNECTIONS:-150}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(track_commit_timestamp) = .*/\1 = on/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(log_min_duration_statement) = .*/\1 = ${PG_LOG_MIN_DURATION_STATEMENT:-0}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(log_line_prefix) = .*/\1 = '%t: db=%d,user=%u '/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(log_min_messages) = .*/\1 = ${PG_LOG_MIN_MESSAGES:-warning}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(synchronous_commit) = .*/\1 = ${PG_SYNCHRONOUS_COMMIT:-off}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(hot_standby) = .*/\1 = ${PG_HOT_STANDBY:-off}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_standby_archive_delay) = .*/\1 = ${PG_MAX_STANDBY_ARCHIVE_DELAY:-30}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(max_standby_streaming_delay) = .*/\1 = ${PG_MAX_STANDBY_STREAMING_DELAY:-30}/" "${PGDATA}/postgresql.conf"
sed -ri "s/#(hot_standby_feedback) = .*/\1 = ${PG_HOT_STANDBY_FEEDBACK:-off}/" "${PGDATA}/postgresql.conf"

if [ "$PG_HOT_STANDBY" = "on" ]; then

wait-for-postgres "postgresql://replicator@master/wal" 2> /dev/null

pg_ctl -D "${PGDATA}" -w stop
rm -rf "${PGDATA}"/*
pg_basebackup -h master -U replicator --xlog-method=stream --progress -v -D "${PGDATA}"

cat > "${PGDATA}/recovery.conf" <<'EOF'
standby_mode = 'on'
primary_conninfo = 'host=master port=5432 user=replicator'
EOF

sed -ri "s/(hot_standby) = .*/\1 = ${PG_HOT_STANDBY:-off}/" "${PGDATA}/postgresql.conf"
sed -ri "s/(max_standby_archive_delay) = .*/\1 = ${PG_MAX_STANDBY_ARCHIVE_DELAY:-10s}/" "${PGDATA}/postgresql.conf"
sed -ri "s/(max_standby_streaming_delay) = .*/\1 = ${PG_MAX_STANDBY_STREAMING_DELAY:-10s}/" "${PGDATA}/postgresql.conf"
sed -ri "s/(hot_standby_feedback) = .*/\1 = ${PG_HOT_STANDBY_FEEDBACK:-off}/" "${PGDATA}/postgresql.conf"

cat "${PGDATA}/postgresql.conf"
pg_ctl -D "${PGDATA}" -w start

else

createuser --replication replicator

cat >> "${PGDATA}/pg_hba.conf" <<'EOF'
host replication replicator 0.0.0.0/0 trust
EOF

/usr/bin/python /db/install.py "postgresql://postgres@localhost:5432" "wal"
fi;
