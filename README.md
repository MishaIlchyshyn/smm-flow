# SMM Flow

SMM Flow is a Ruby on Rails application for social media marketing agencies. It gives a small agency one place to manage clients, track ongoing SMM projects, capture brand strategy, and plan content across platforms.

Without a tool like this, agency work is often split across chats, notes, spreadsheets, and documents. SMM Flow brings that workflow into a single app so teams can move from client onboarding to project execution with less context switching.

## What Problem It Solves

SMM Flow is built for agencies that need to:

- keep client information organized
- track projects per client
- document brand positioning and strategy inputs
- plan and monitor upcoming content pieces

In practice, it helps answer:

- Who is this client and what stage are they in?
- What projects are active right now?
- Is the brand positioning filled in and complete?
- What content is scheduled next for Instagram, YouTube, TikTok, or LinkedIn?

## Quick Start

If you want to get the app running as fast as possible:

```bash
git clone git@github.com:MishaIlchyshyn/smm-flow.git
cd smm-flow
bin/setup
```

Then open `http://localhost:3000`.

If port `3000` is already occupied:

```bash
PORT=3001 bin/dev
```

## Features

- Agency workspace with owner registration flow
- Authentication with Devise
- Client management with lead, customer, and terminated states
- Projects linked to clients
- Brand positioning forms for strategy details
- Content planning by platform, content type, schedule, and status

## Tech Stack

- Ruby 3.4.8
- Rails 8.1.3
- PostgreSQL
- Devise for authentication
- Hotwire: Turbo + Stimulus
- Importmap for JavaScript
- Tailwind CSS
- Solid Queue, Solid Cache, and Solid Cable
- Kamal for deployment

## Prerequisites

Make sure the following are installed locally:

- Ruby 3.4.8
- Bundler
- PostgreSQL

## Local Setup

1. Clone the repository:

   ```bash
   git clone git@github.com:MishaIlchyshyn/smm-flow.git
   cd smm-flow
   ```

2. Install dependencies and prepare the database:

   ```bash
   bin/setup
   ```

   This command installs gems, prepares the database, clears temp files, and starts the development server unless `--skip-server` is passed.

3. If you only want setup without starting the app:

   ```bash
   bin/setup --skip-server
   ```

4. Start the development environment:

   ```bash
   bin/dev
   ```

   The app runs on `http://localhost:3000` by default.

   If port `3000` is already occupied, start it on another port:

   ```bash
   PORT=3001 bin/dev
   ```

## Database

The development and test environments use PostgreSQL databases named:

- `smm_flow_development`
- `smm_flow_test`

If you need to prepare the database manually, run:

```bash
bin/rails db:prepare
```

To fully reset the local database through the setup script, run:

```bash
bin/setup --reset --skip-server
```

## Running Tests and Checks

Run the Rails test suite:

```bash
bin/rails test
```

Run the full CI command set locally:

```bash
bin/ci
```

That includes setup, RuboCop, security audits, Brakeman, Rails tests, and seed validation in test environment.

## Development Notes

- New users sign up through a custom registration flow that also creates their first agency and owner membership.
- `bin/dev` uses Foreman and will install it automatically if it is missing.
- No sample seed data is included yet in `db/seeds.rb`.

## Deployment

The project includes Kamal configuration in `config/deploy.yml` for container-based deployment.
