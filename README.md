# db-version ansible
This is a variant of how db versioning was at a job i was at, i like it alot in many cases since you can roll forward. 

I vibed this since i was a bit miffed, looking at the output it looks fine for now... i dont have to many version yet. 

This repository is supposed to be copied into another repo, im just keeping a clean copy here.

## What is the structure?
inside the `version` folder there are versioned folders like `0.0.0`, which is the inital version.

Inside the version folder there are files with this structure `xxx-yyy-name.sql`. `xxx-yyy` is for sorting but also to tell the scripts from patch version `xxx` to `yyy`.

```
version/
├── 0.0.0
│   └── 000-001-create-version-table.sql
└── 0.0.1
    └── 000-001-example.sql
```

In the example above it creates the initial version `0.0.0.1` which contains the schema version table, then it applies the patches for version `0.0.1` 
this database would have records for version `0.0.0` with patch `1`, `0.0.1` with patch `1`.

I called `patch` `minor` when i told claude my idea so its incorrect in the table... but meh. 


## Getting started

you need to install this.
```
pip install psycopg2
```

## What do i need to change?
the vars in `migrate.yml`
```
db_name: "example"
db_user: "postgres"
db_host: "localhost"
db_port: 5432
```
## How do i use it.
How to run.
```
ansible-playbook migrate.yml --extra-vars db_password=password
```

## Notes

The OG version had support for schemas but i did not care to implement them right now... i might regret it later, but no one used it and it was later removed.
It looked like this.
```
version/
├── 0.0.0
│   └── 000-001-create-version-table.sql
└── schema
    └── 0.0.0
```
if the folder name didnt match a regex like `\d.\d.\d` and had a folder that did under it; it was a schema.
