# Vector Home Assistant Add-ons

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fbencarver%2Fvector_ha_addon)

## Add-ons

This repository contains the following add-ons:

### [Vector](./vector)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armv7 Architecture][armv7-shield]

A high-performance observability data pipeline for logs, metrics, and traces.

## Installation

1. Click the button above, or:
2. Navigate to **Settings** → **Add-ons** → **Add-on Store** → ⋮ → **Repositories**
3. Add this URL: `https://github.com/bencarver/vector_ha_addon`
4. Find "Vector" in the store and install

## About Vector

[Vector](https://vector.dev) is a lightweight, ultra-fast tool for building observability pipelines. Use it to collect and route Home Assistant logs to:

- **Loki / Grafana** - Log aggregation and visualization
- **Elasticsearch** - Full-text search and analytics  
- **InfluxDB** - Time-series metrics
- **Datadog** - Cloud monitoring
- **And many more...**

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
