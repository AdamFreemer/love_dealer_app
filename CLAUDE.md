# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Rails 8.1 application using Hotwire (Turbo + Stimulus), TailwindCSS, and PostgreSQL. It uses the modern Solid* stack (Solid Queue, Solid Cache, Solid Cable) instead of Redis.

## Development Commands

### Setup and Running
- `bin/setup` - Install dependencies and setup database (use `--reset` to reset DB, `--skip-server` to skip starting)
- `bin/dev` - Start development server with Foreman (runs Puma + TailwindCSS watcher)
- `bin/rails server` - Start Rails server only (port 3000)
- `bin/rails console` - Rails console

### Testing
- `bin/rails test` - Run all tests (Minitest with parallel execution)
- `bin/rails test test/path/to/specific_test.rb` - Run single test file
- `bin/rails test test/path/to/specific_test.rb:LINE` - Run specific test by line number
- `bin/rails test:system` - Run system tests (Capybara + Selenium)

### Linting and Security
- `bin/rubocop` - Lint Ruby code (Omakase style)
- `bin/brakeman` - Security vulnerability scanning
- `bin/bundler-audit` - Gem vulnerability scanning
- `bin/importmap audit` - JavaScript dependency audit

### Database
- `bin/rails db:prepare` - Setup/prepare database
- `bin/rails db:migrate` - Run migrations
- `bin/rails db:seed` - Seed database

### Docker and Deployment
- `docker build -t love_dealer_app .` - Build production image
- `bin/kamal` - Kamal deployment orchestration
- Kamal aliases: `kamal console`, `kamal shell`, `kamal logs`, `kamal dbc`

## Architecture

### Tech Stack
- **Ruby 3.3.6 / Rails 8.1.2**
- **Database**: PostgreSQL (primary), plus separate DBs for queue/cache/cable
- **Frontend**: Hotwire (Turbo + Stimulus), TailwindCSS, ImportMap (no JS bundler)
- **Asset Pipeline**: Propshaft
- **Background Jobs**: Solid Queue (database-backed, can run in-process with Puma)
- **Caching**: Solid Cache (database-backed)
- **WebSockets**: Solid Cable (database-backed)
- **Deployment**: Kamal with Docker

### Key Directories
- `app/javascript/controllers/` - Stimulus controllers
- `app/views/layouts/application.html.erb` - Main layout (TailwindCSS)
- `config/importmap.rb` - JavaScript dependency pins
- `db/queue_schema.rb`, `db/cache_schema.rb`, `db/cable_schema.rb` - Solid* schemas

### Configuration
- Credentials: `config/credentials.yml.enc` (edit with `bin/rails credentials:edit`)
- Environment variables: `RAILS_ENV`, `RAILS_MASTER_KEY`, `DATABASE_URL`, `RAILS_LOG_LEVEL`
- Kamal secrets: `.kamal/secrets`

### CI Pipeline (.github/workflows/ci.yml)
Runs on PRs and pushes to main:
1. Security scans (Brakeman, bundler-audit, importmap audit)
2. Linting (RuboCop)
3. Tests (with PostgreSQL service)
4. System tests (with screenshot artifacts on failure)

## Notes

- PWA manifest and service worker are set up but disabled in routes
- Solid Queue can run in-process with Puma (`SOLID_QUEUE_IN_PUMA=true`) or as a separate process
- Health check endpoint: `/up`
- Modern browser support enforced (webp, web push, CSS nesting required)
