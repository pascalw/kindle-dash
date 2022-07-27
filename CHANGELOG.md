# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v1.0.0-beta.4] - 2022-07-27

### Changed

- Only call eips if fetch-dashboard succesfully completes
- Ensure a full screen refresh is triggered after wake from sleep
- Build ht from upstream sources, using rusttls instead of vendored openssl
- Replace ht 0.4.0 with xh 0.16.1 (project was renamed)

## [v1.0.0-beta.3] - 2020-02-03

### Changed

- Use 1.1.1.1 as default Wi-Fi test ip
- Use a more standards-compliant cron parser (BREAKING)

### Added

- Add low battery reporting (`local/low-battery.sh`)
- Add debug mode (DEBUG=true start.sh)
- SSH server prerequisite in docs (@julianlam)

### Fixed

- Typos (@jcmiller11, @starcoat)

## [v1.0.0-beta-2] - 2020-01-26

### Removed

- Power state logging

## [v1.0.0-beta-1] - 2020-01-26

Initial release 🎉
