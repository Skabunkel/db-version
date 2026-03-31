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
│   ├── 000-001-asdasasdasd.sql
│   └── 000-001-create-version-table.sql
├── goober
└── goober2
    └── 0.0.0
        └── 000-001-asdasasdasd.sql
```

In the example above it creates the initial version `0.0.0.1` which contains the schema version table, then it applies the patches for version `0.0.1` 
this database would have records for version `0.0.0` with patch `1`, `0.0.1` with patch `1`.

This version now supports the creation of schema and will write the sql into a schema if the folder has a version folder in it.

Schemas are manage by setting search_path on the runner ansible statment, meaning you dont need to set it in scripts.


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
ansible-playbook main.yml --extra-vars db_password=password
```

