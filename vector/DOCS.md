# Home Assistant Add-on: Vector

## About

[Vector](https://vector.dev) is a high-performance, end-to-end observability data pipeline. This add-on allows you to collect, transform, and route logs and metrics from your Home Assistant instance to various destinations.

## Features

- **Collect** logs from Home Assistant and other sources
- **Transform** data with Vector Remap Language (VRL)
- **Route** to multiple destinations (Loki, Elasticsearch, InfluxDB, etc.)
- **Monitor** with built-in metrics and health checks
- **GraphQL Playground** for exploring your data

## Installation

1. Add this repository to your Home Assistant Add-on Store
2. Install the "Vector" add-on
3. Configure your Vector pipeline
4. Start the add-on

## Configuration

### Add-on Options

| Option | Description | Default |
|--------|-------------|---------|
| `config_path` | Path to Vector config file | `/config/vector/vector.yaml` |
| `api_enabled` | Enable Vector API | `true` |
| `api_address` | API listen address | `0.0.0.0:8686` |
| `log_level` | Log verbosity | `info` |

### Vector Configuration

Edit `/config/vector/vector.yaml` to customize your pipeline. The default configuration:

- Reads Home Assistant logs from `/config/home-assistant.log`
- Parses the log format into structured data
- Outputs to console (for debugging)

### Example: Send Logs to Loki

```yaml
sinks:
  loki:
    type: loki
    inputs:
      - parse_ha_logs
    endpoint: http://loki:3100
    labels:
      application: homeassistant
    encoding:
      codec: json
```

### Example: Send Metrics to Prometheus

```yaml
sinks:
  prometheus:
    type: prometheus_exporter
    inputs:
      - vector_metrics
    address: "0.0.0.0:9598"
```

### Example: Send to Elasticsearch

```yaml
sinks:
  elasticsearch:
    type: elasticsearch
    inputs:
      - parse_ha_logs
    endpoints:
      - http://elasticsearch:9200
    index: homeassistant-%Y-%m-%d
```

### Example: Forward to Datadog

```yaml
sinks:
  datadog:
    type: datadog_logs
    inputs:
      - parse_ha_logs
    default_api_key: "${DATADOG_API_KEY}"
    site: datadoghq.com
```

## Advanced Configuration

### Multiple Sources

You can add additional sources to collect data from various places:

```yaml
sources:
  # Syslog input
  syslog:
    type: syslog
    address: "0.0.0.0:514"
    mode: tcp

  # HTTP endpoint for custom events
  http_events:
    type: http_server
    address: "0.0.0.0:8080"
    encoding: json
```

### Custom Transforms

Use Vector Remap Language (VRL) to transform your data:

```yaml
transforms:
  enrich_logs:
    type: remap
    inputs:
      - parse_ha_logs
    source: |
      # Add custom fields
      .environment = "production"
      .hostname = get_hostname!()
      
      # Redact sensitive data
      .message = redact(.message, filters: ["pattern"], redactor: "[REDACTED]")
```

### Buffering and Batching

Configure disk buffering for reliability:

```yaml
sinks:
  loki:
    type: loki
    inputs:
      - parse_ha_logs
    endpoint: http://loki:3100
    buffer:
      type: disk
      max_size: 104900000  # 100MB
      when_full: block
    batch:
      max_bytes: 1048576   # 1MB
      timeout_secs: 5
```

## API & Playground

When enabled, the Vector API provides:

- **Health endpoint**: `http://<your-ha>:8686/health`
- **GraphQL API**: `http://<your-ha>:8686/graphql`
- **Playground**: `http://<your-ha>:8686/playground`

The Playground is useful for:
- Viewing pipeline topology
- Checking component health
- Exploring metrics
- Testing VRL expressions

## Troubleshooting

### Check Vector Status

Access the add-on logs in Home Assistant to see Vector's output.

### Validate Configuration

Vector validates the configuration on startup. Check the logs for any validation errors.

### Common Issues

1. **Permission denied reading logs**: Ensure the add-on has access to the config folder
2. **Connection refused to sink**: Verify the endpoint is reachable from the container
3. **Memory usage high**: Adjust buffer sizes and batch settings

### Debug Mode

Set `log_level` to `debug` or `trace` for more verbose output.

## Resources

- [Vector Documentation](https://vector.dev/docs/)
- [VRL Reference](https://vector.dev/docs/reference/vrl/)
- [Vector Sources](https://vector.dev/docs/reference/configuration/sources/)
- [Vector Sinks](https://vector.dev/docs/reference/configuration/sinks/)
- [Issue Tracker](https://github.com/bencarver/vector_ha_addon/issues)

