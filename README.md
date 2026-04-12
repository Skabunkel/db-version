# db-version ansible

A simple, roll-forward database versioning tool built on Ansible. Inspired by a system used at a previous job.

Copy this repo into your own project — this is just a clean reference copy.

## What is the structure?

Versioned SQL lives under `version/<schema>/<version>/`. Each file is named `xxx-yyy-name.sql`, where `xxx` is the starting patch and `yyy` is the target patch. Files are applied in order and skipped if already applied.

```
version/
├── goober2
│   └── 0.0.0
│       ├── 000-001-init.sql
│       └── 001-002-create-stuff-table.sql
└── goober        # no version folder → skipped
```

In the example, schema `goober2` is created at version `0.0.0`, then patches are applied up to patch `2`. The tool tracks applied versions/patches in a schema version table so re-runs are safe.

Once a version folder (e.g. `0.0.0`) is released, don't modify it — create a new version folder (e.g. `0.0.1`) for further changes.

## Getting started

Install the Postgres driver:

```
# psycopg version 3
pip install "psycopg[binary]"
# or, version 2:
pip install psycopg2
# or, for prebuilt binaries:
pip install psycopg2-binary
```

You also need Ansible installed.

## What do i need to change?

Edit `.vars.yml` with your database connection details:

```
db_name: "example"
db_user: "postgres"
db_host: "localhost"
db_port: 5432
```

Then add your SQL files under `version/<version>/` or on a schema `version/<schema>/<version>/`.

## How do i use it.

Run the playbook, passing the DB password as an extra var:

```
ansible-playbook main.yml --extra-vars db_password=password
```

The tool will:

1. Read `.vars.yml` for connection info.
2. Ensure the schema version table exists.
3. Apply any patches that haven't been applied yet, in order.
4. Skip schemas that have no version folder.

To add a new change, drop a new `xxx-yyy-name.sql` into the current version folder (or create a new version folder) and re-run.

## Examples

### 1. A simple first patch

This patch is applied to the schema public.

`version/0.0.0/000-001-create-genres.sql`:

```sql
CREATE TABLE IF NOT EXISTS genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### 2. Adding the next patch

`version/0.0.0/001-002-create-authors.sql` — note the filename picks up where the previous one left off (`001` → `002`):

```sql
CREATE TABLE IF NOT EXISTS authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL
);
```

### 3. A new version (schema change released later)

Once `0.0.0` is in production, don't edit it. Create `version/0.1.0/000-001-add-author-email.sql`:

```sql
ALTER TABLE authors ADD COLUMN email VARCHAR(200);
```

### 4. A separate schema

Anything outside a `x.y.z` folder is treated as a named schema. `version/orders/0.0.0/000-001-create-orders.sql` will be created in schema `orders`:

```sql
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    placed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### 5. Using variables in SQL

SQL files are rendered as Jinja templates, so any variable from `.vars.yml` (or `--extra-vars`) is available. Use `{{ var }}` for substitution.

`.vars.yml`:

```yaml
db_name: "example"
db_user: "postgres"
app_owner: "app_user"
```

`version/0.0.0/002-003-grant-app-user.sql`:

```sql
CREATE USER {{ app_owner }};
GRANT USAGE ON SCHEMA public TO {{ app_owner }};
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO {{ app_owner }};
```

Run with an override if you want:

```
ansible-playbook main.yml --extra-vars "db_password=secret app_owner=reporting_user"
```

## Rules of thumb

- Filenames must be sequential: `000-001`, `001-002`, `002-003`, ... — the next file's first number must match the previous file's second number.
- Never edit a released version folder. Create a new one.
- Every SQL file must be non-empty.
- `{{ ... }}` is interpreted as Jinja2 template — escape literal `%` as `%%`.
