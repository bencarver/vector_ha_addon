# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-12

### Added

- Initial release of Vector Home Assistant Add-on
- Vector v0.39.0 observability pipeline
- Support for amd64, aarch64, and armv7 architectures
- Default configuration for Home Assistant log parsing
- VRL transform to parse Home Assistant log format
- GraphQL API and Playground support
- Health check endpoint at `/health`
- Ingress support for sidebar integration
- Configuration options:
  - Custom config file path
  - API enable/disable
  - API address configuration
  - Log level selection
- Example configurations for popular sinks:
  - Loki
  - Prometheus
  - InfluxDB
  - Elasticsearch
  - Datadog

