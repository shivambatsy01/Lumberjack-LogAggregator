CREATE DATABASE IF NOT EXISTS logging;

CREATE TABLE IF NOT EXISTS logging.logs
(
    trace_id String,
    log_level Enum8 (
        'LOG_LEVEL_UNSPECIFIED' = 0,
        'DEBUG' = 1,
        'INFO' = 2,
        'WARN' = 3,
        'ERROR' = 4
    ),
    service_name LowCardinality(String),
    timestamp DateTime64(3, 'UTC'),
    message String
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(timestamp)
ORDER BY (service_name, log_level, timestamp)
TTL timestamp + INTERVAL 90 DAY;
