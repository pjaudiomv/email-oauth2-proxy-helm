# Email OAuth2 Proxy Docker Image

This document provides instructions for using the Email OAuth2 Proxy Docker image.

## Quick Start

```bash
docker run -p 2993:2993 email-oauth2-proxy
```

## Image Details

- **Base Image**: Python 3.12-slim
- **Default Config Path**: `/app/emailproxy.config`

## Configuration

### Environment Variables

### Common Configuration Options

| Environment Variable | Description                               | Default                  |
|----------------------|-------------------------------------------|--------------------------|
| `CONFIG_FILE`        | Path to configuration file                | `/app/emailproxy.config` |
| `CACHE_STORE`        | Path to cache file                        |                          |
| `DEBUG`              | Turns on debugging if set to true         |                          |
| `LOCAL_SERVER_AUTH`  | Use local auth vs external is set to true |                          |


### Advanced TOML Configuration via Environment Variables

You can configure any section/key in your TOML config file using environment variables with the following conventions:

| Environment Variable Example                              | TOML Section Example         | TOML Key Example      | Resulting Config Line                        | Notes                                                                                 |
|----------------------------------------------------------|-----------------------------|-----------------------|----------------------------------------------|---------------------------------------------------------------------------------------|
| `EMAILPROXY_SMTP_1587_SERVER_PORT=587`                   | `[SMTP-1587]`               | `server_port`         | `server_port = "587"`                        | For server sections, use underscores for dashes.                                      |
| `EMAILPROXY_IMAP_1993_SERVER_ADDRESS=imap.example.com`   | `[IMAP-1993]`               | `server_address`      | `server_address = "imap.example.com"`         |                                                                                       |
| `EMAILPROXY_POP_2995_LOCAL_ADDRESS=127.0.0.1`            | `[POP-2995]`                | `local_address`       | `local_address = "127.0.0.1"`                 |                                                                                       |
| `EMAILPROXY_SMTP_1587_SERVER_STARTTLS=True`              | `[SMTP-1587]`               | `server_starttls`     | `server_starttls = "True"`                    |                                                                                       |
| `EMAILPROXY_YOUR__EMAIL_GMAIL_COM_CLIENT_ID=abc123`      | `[your.email@gmail.com]`    | `client_id`           | `client_id = "abc123"`                        | Use double underscores (`__`) for dots in section names (e.g., email addresses).       |
| `EMAILPROXY_YOUR__EMAIL_GMAIL_COM_CLIENT_SECRET=secret`  | `[your.email@gmail.com]`    | `client_secret`       | `client_secret = "secret"`                     |                                                                                       |
| `EMAILPROXY_SERVICE__ACCOUNT_ACCESSIBLE_ADDRESS__YOUR__DOMAIN_COM_TOKEN_URL=https://...` | `[service.account.accessible.address@your-domain.com]` | `token_url` | `token_url = "https://..."` | Use double underscores for each dot in section name.                                   |
| `EMAILPROXY_IMAP_1993_DOCUMENTATION=Some note`           | `[IMAP-1993]`               | `documentation`       | `documentation = "Some note"`                  |                                                                                       |

> **Note:** For account sections (e.g., `[your.email@gmail.com]`), use `_AT_` for `@` and double underscores (`__`) for `.` in the environment variable name. **Use a double underscore (`__`) to separate the section from the key.**
>
> **Examples:**
> - `[john.doe@company.com] client_id = "yolo"` → `EMAILPROXY_JOHN__DOE_AT_COMPANY__COM__CLIENT_ID="yolo"`
> - `[alice.smith@foo.org] client_secret = "abc"` → `EMAILPROXY_ALICE__SMITH_AT_FOO__ORG__CLIENT_SECRET="abc"`

#### Conventions

- **Section Name Mapping:**
  - Single underscore (`_`) → dash (`-`) in section name.
  - Double underscores (`__`) → dot (`.`) in section name (for email addresses or domains).
- **Key Name Mapping:**
  - Everything after the last underscore is the key (converted to lowercase).

### Custom Configuration File

To use a custom configuration file:

```bash
# Mount a local config file
docker run -v /path/to/your/emailproxy.config:/app/emailproxy.config email-oauth2-proxy

# Or specify a different path
docker run -e CONFIG_FILE=/custom/path/emailproxy.config email-oauth2-proxy
```

## Usage Examples

### Basic Usage

```bash
docker run -p 2993:2993 email-oauth2-proxy
```

### Custom Ports

```bash
# Run with custom ports
docker run \
  -p 1430:1430 -p 2525:2525 \
  -e EMAILPROXY_IMAP_PORT=1430 \
  -e EMAILPROXY_SMTP_PORT=2525 \
  email-oauth2-proxy
```
