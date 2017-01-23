Ansible Role: Apache Archiva
============================

Installs [Apache Archiva](https://archiva.apache.org).

Requirements
------------

Archiva [system requirements](https://archiva.apache.org/download.cgi):

* **JDK**: 1.7 or above
* **No minimum requirement**: The Archiva application is in itself about 50MB but will use more disk space to store repository contents
* **Operating System**: Support for Linux, Mac OS, Solaris and Windows. Tested on Windows XP SP2, Ubuntu Linux, and Mac OS X.

Currently this role supports only Ubuntu Linux. Feel free to extend it to other platforms.

Role Variables
--------------

#### Default variables:

  *  `archiva.version` - Apache Archiva version (default is _2.2.1_)
  *  `archiva.downloadbase_url` - The base url of the binary (_see_ `templates/download_url.j2`)
  * `archiva.install_path` - Where to install Archiva
  * `archiva.install_name` - Name of the installation folder
  * `archiva.createAdminUserEndpoint` - REST endpoint to create admin user
  * `archiva.createUserEndpoint` - REST endpoint to create a user
  * `archiva.loginEndpoint` - REST endpoint to login with a user

#### Playbook variables

  * `archiva_admin_email` - Email address of the admin user
  * `archiva_admin_password` - Password of the admin user
  * `archiva_users` - List of users to create. Following fields are required per user:
    * `username`
    * `password`
    * `email`
    * `fullName`
    * `roles` - List of strings of the roles. See `tests/example-playbook.yml`.


Dependencies
------------
`gantsign.java`

Variables used by role dependency:

```ansible
    # For more info see: https://galaxy.ansible.com/gantsign/java/
    java_version: '8u112'
    java_license_declaration: ...
```

Example Playbook
----------------

An example playbook for the role that automatically creates the `admin` user
and a `deploy` user with the proper roles assigned.

```ansible
# Example playbook for ansible-role-archiva

- hosts: servers
  roles:
     - {
        role: sperka.archiva,
        archiva_admin_email: admin@archiva-test.org,
        archiva_admin_password: adminPass123,
        archiva_users:
            - username: deploy
              password: deployPass123
              email: deploy@archiva-test.org
              fullName: Deploy User
              roles:
                - "Global Repository Manager"
                - "Global Repository Observer"
                - "Registered User"
                - "Repository Manager - internal"
                - "Repository Observer - internal"
                - "Repository Observer - snapshots"
                - "Repository Manager - snapshots"
      }
```

License
-------

BSD

Author Information
------------------

https://github.com/sperka
