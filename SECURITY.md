# Security Policy

## Scope

This project is a **local development environment** for WordPress, built with
Docker Compose. It is intended for use on a developer's machine and is **not
hardened for, or intended to be exposed to, the public internet or production
use**. Several defaults reflect that (a self-signed local certificate, a
default database password, an open phpMyAdmin, and the MySQL port published to
`localhost`).

Please keep that context in mind when reporting issues: a report is most useful
when it describes a problem that affects developers running this stack locally,
or a default that could surprise someone who deploys it beyond a local machine.

## Supported versions

Only the latest release on the `master` branch is supported. Fixes are applied
there; older revisions do not receive backported patches.

| Version          | Supported          |
| ---------------- | ------------------ |
| `master` (latest)| :white_check_mark: |
| Older commits    | :x:                |

Because this is a boilerplate you customize, you are responsible for keeping the
components you build on top of it up to date — in particular WordPress core and
plugins (via `composer update` in `src/`), the base Docker images
(`mariadb`, `nginx`, `phpmyadmin`, the custom WordPress/PHP image), and the
theme's npm dependencies.

## Reporting a vulnerability

**Please do not open a public GitHub issue for security problems.**

Report privately through GitHub's **[Private vulnerability reporting](https://github.com/urre/wordpress-nginx-docker-compose/security/advisories/new)**:

1. Go to the **Security** tab of the repository.
2. Click **Report a vulnerability** to open a private draft advisory.
3. Include:
   - A description of the issue and its impact.
   - Steps to reproduce (commands, config, affected files).
   - The affected component and version (Docker image tag, package, commit).
   - Any suggested fix or mitigation, if you have one.

If private reporting is unavailable to you, contact the maintainer directly
rather than filing a public issue.

## What to expect

- **Acknowledgement:** typically within a few days. This is a volunteer,
  best-effort open-source project, so response times are not guaranteed.
- **Updates:** you'll be kept informed as the report is triaged.
- **Resolution:** confirmed issues are fixed on `master`; you will be credited
  in the advisory unless you prefer to remain anonymous.
- **Declined reports:** if the report is out of scope (see **Scope** above) or
  not reproducible, you'll get an explanation.

Thank you for helping keep this project and its users safe.
