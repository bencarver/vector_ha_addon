# Vector Home Assistant Add-on

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armv7 Architecture][armv7-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg

## About

A Home Assistant add-on for [Vector](https://vector.dev) - a high-performance observability data pipeline.

Collect, transform, and route your Home Assistant logs and metrics to any destination:

- **Loki / Grafana** - For log aggregation and visualization
- **Elasticsearch** - Full-text search and analytics
- **InfluxDB** - Time-series metrics storage
- **Prometheus** - Metrics monitoring
- **Datadog** - Cloud monitoring platform
- **S3 / GCS** - Long-term log archival
- And [many more...](https://vector.dev/docs/reference/configuration/sinks/)

## Features

✨ **Powerful Log Processing** - Parse, filter, and transform logs with VRL  
🚀 **High Performance** - Written in Rust for maximum efficiency  
🔌 **Multiple Destinations** - Route to any supported sink  
📊 **Built-in Metrics** - Monitor Vector's own performance  
🎮 **GraphQL Playground** - Explore your data interactively  
🏠 **Home Assistant Integration** - Ingress support and sidebar panel  

## Installation

### Option 1: Add Repository

1. Navigate to **Settings** → **Add-ons** → **Add-on Store**
2. Click the menu (⋮) → **Repositories**
3. Add this repository URL:
   ```
   https://github.com/bencarver/vector_ha_addon
   ```
4. Find "Vector" in the add-on store and click **Install**

### Option 2: Manual Installation

1. Clone this repository to your Home Assistant addons folder:
   ```bash
   cd /addons
   git clone https://github.com/bencarver/vector_ha_addon vector
   ```
2. Restart Home Assistant
3. Navigate to **Settings** → **Add-ons** → **Vector** → **Install**

## Quick Start

1. Install the add-on
2. Start the add-on
3. Edit `/config/vector/vector.yaml` to configure your pipeline
4. Restart the add-on to apply changes

## Configuration

See [DOCS.md](DOCS.md) for complete documentation including:

- Configuration options
- Example pipelines (Loki, Elasticsearch, InfluxDB, etc.)
- Advanced transforms with VRL
- Troubleshooting guide

## Example: Send Logs to Loki

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

## Support

- 📖 [Vector Documentation](https://vector.dev/docs/)
- 🐛 [Report Issues](https://github.com/bencarver/vector_ha_addon/issues)
- 💬 [Home Assistant Community](https://community.home-assistant.io/)

## License

MIT License - See [LICENSE](LICENSE) for details.

