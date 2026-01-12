# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.10] - 2026-01-12

### Added

- Configurable Betterstack endpoint for regional URLs
- HTTP log ingestion endpoint (port 8687) for Home Assistant OS compatibility
- Documentation for setting up HA automations to forward logs

### Changed

- Switched from file-based log reading to HTTP-based ingestion
- Updated Vector to v0.42.0
- Simplified addon configuration options (removed unused API settings)
- Updated documentation with complete Betterstack setup guide

### Fixed

- VRL syntax errors in log transforms
- Buffer size configuration (switched to memory buffer)
- Regional Betterstack endpoint support

## [1.0.0] - 2026-01-12

### Added

- Initial release of Vector Home Assistant Add-on
- Vector v0.42.0 observability pipeline
- Support for amd64, aarch64, and armv7 architectures
- Betterstack integration for log forwarding
- GraphQL API and Playground support (port 8686)
- HTTP log ingestion endpoint (port 8687)
- Health check endpoint at `/health`
- Ingress support for sidebar integration
- Configuration options:
  - Log level selection
  - Betterstack source token
  - Betterstack endpoint URL
- Example configurations for popular sinks:
  - Betterstack
  - Loki
  - Elasticsearch
  - Datadog
