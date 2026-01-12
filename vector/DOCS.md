# Home Assistant Add-on: Vector

## About

[Vector](https://vector.dev) is a high-performance, end-to-end observability data pipeline. This add-on allows you to collect, transform, and route logs and metrics from your Home Assistant instance to various destinations.

## Features

- **Collect** logs from Home Assistant via HTTP endpoint
- **Transform** data with Vector Remap Language (VRL)
- **Route** to Betterstack, Loki, Elasticsearch, and more
- **Monitor** with built-in metrics and health checks
- **GraphQL Playground** for exploring your data

## Quick Start with Betterstack

### Step 1: Configure Betterstack Source

1. Log in to [Betterstack](https://logs.betterstack.com)
2. Go to **Sources** → **Connect source**
3. Choose **HTTP**
4. Copy the **Source token**
5. Copy the **Ingestion host** (e.g., `https://s1234567.eu-nbg-2.betterstackdata.com`)

### Step 2: Configure the Addon

1. Go to **Settings** → **Add-ons** → **Vector** → **Configuration**
2. Set **Betterstack Source Token** to your token
3. Set **Betterstack Endpoint** to your ingestion host URL
4. Click **Save** and **Restart**

### Step 3: Set Up Log Forwarding (Home Assistant OS)

Add this to your `configuration.yaml`:

```yaml
rest_command:
  send_log_to_vector:
    url: "http://294bc44e-vector:8687/logs"
    method: POST
    content_type: "application/json"
    payload: '{"message": "{{ message }}", "level": "{{ level }}", "name": "{{ name }}", "timestamp": "{{ timestamp }}"}'
```

Then create an automation (**Settings** → **Automations** → **Create**):

```yaml
alias: Forward Notifications to Vector
trigger:
  - platform: event
    event_type: call_service
    event_data:
      domain: persistent_notification
      service: create
action:
  - service: rest_command.send_log_to_vector
    data:
      message: "{{ trigger.event.data.service_data.message | default('') }}"
      level: "error"
      name: "{{ trigger.event.data.service_data.title | default('notification') }}"
      timestamp: "{{ now().isoformat() }}"
mode: queued
```

Optional heartbeat automation (to detect when HA goes offline):

```yaml
alias: Vector Heartbeat
trigger:
  - platform: time_pattern
    minutes: "/1"
action:
  - service: rest_command.send_log_to_vector
    data:
      message: "Home Assistant heartbeat"
      level: "info"
      name: "heartbeat"
      timestamp: "{{ now().isoformat() }}"
mode: single
```

### Step 4: Test

1. Go to **Developer Tools** → **Actions**
2. Run `rest_command.send_log_to_vector` with test data
3. Check Betterstack Live Tail for the log!

## Configuration

### Add-on Options

| Option | Description | Default |
|--------|-------------|---------|
| `log_level` | Log verbosity | `info` |
| `betterstack_token` | Betterstack source token | (empty) |
| `betterstack_endpoint` | Betterstack ingestion URL | `https://in.logs.betterstack.com` |

### Betterstack Endpoint

**Important:** Betterstack uses regional endpoints. Find your specific endpoint in your Betterstack source settings.

Examples:
- Default: `https://in.logs.betterstack.com`
- EU region: `https://s1234567.eu-nbg-2.betterstackdata.com`

## How It Works

```
Home Assistant → Automation → HTTP POST → Vector → Betterstack
                                (port 8687)
```

1. HA automation triggers on events (notifications, errors, etc.)
2. Sends JSON payload to Vector's HTTP endpoint (port 8687)
3. Vector transforms and enriches the data
4. Vector forwards to Betterstack (or other sinks)

## API & Playground

The Vector API runs on port 8686:

- **Health endpoint**: `http://<your-ha>:8686/health`
- **GraphQL API**: `http://<your-ha>:8686/graphql`
- **Playground**: `http://<your-ha>:8686/playground`

## Advanced Configuration

Edit `/config/vector/vector.yaml` to customize the pipeline.

### Add Additional Sinks

```yaml
sinks:
  # Add Loki
  loki:
    type: loki
    inputs:
      - process_ha_logs
    endpoint: http://loki:3100
    labels:
      application: homeassistant
    encoding:
      codec: json
```

## Troubleshooting

### 401 Unauthorized from Betterstack

- Verify your token is correct
- Check you're using the correct regional endpoint
- Create a new HTTP source in Betterstack

### Logs not appearing

1. Check Vector addon logs for errors
2. Test the rest_command manually in Developer Tools
3. Verify the automation is enabled

### Connection refused

- Check the addon hostname (usually `294bc44e-vector`)
- Verify port 8687 is exposed

### Debug Mode

Set `log_level` to `debug` for verbose output.

## Resources

- [Vector Documentation](https://vector.dev/docs/)
- [Betterstack Docs](https://betterstack.com/docs/logs/)
- [Issue Tracker](https://github.com/bencarver/vector_ha_addon/issues)
