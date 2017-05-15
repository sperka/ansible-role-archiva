Ansible Role: Apache Archiva
============================

[![Build Status](https://travis-ci.org/sperka/ansible-role-archiva.svg?branch=master)](https://travis-ci.org/sperka/ansible-role-archiva)

Installs [Apache Archiva](https://archiva.apache.org).

Requirements
------------

This role supports **only Ubuntu Linux**. Feel free to extend it to other platforms.

Archiva [system requirements](https://archiva.apache.org/download.cgi):

*   **JDK**: 1.7 or above
*   **No minimum requirement**: The Archiva application is in itself about 50MB but will use more disk space to store repository contents
*   **Operating System**: Support for Linux, Mac OS, Solaris and Windows. Tested on Windows XP SP2, Ubuntu Linux, and Mac OS X.

Role Variables
--------------

#### Default variables:

*   `archiva.version` - Apache Archiva version (default is _2.2.1_)
*   `archiva.download_base_url` - The base url of the binary (_see_ `templates/download_url.j2`)
*   `archiva.install_path` - Where to install Archiva
*   `archiva.createAdminUserEndpoint` - REST endpoint to create admin user
*   `archiva.createUserEndpoint` - REST endpoint to create a user
*   `archiva.updateUserRolesEndpoint` - REST endpoint to update user's role
*   `archiva.loginEndpoint` - REST endpoint to login with a user
*   `archiva.passwordExpirationEnabled` - Enable/disable password expiration for users (default: false)

#### Playbook variables

For use the proper user parameters, please see [Apache Archiva Redback REST API](http://archiva.apache.org/docs/2.2.1/rest-docs-redback-rest-api/index.html) and
[Apache Archiva Web REST support API](http://archiva.apache.org/docs/2.2.1/rest-docs-archiva-rest-api/index.html).

*   `configonly` - Indicates if you want to run this role only to configure users
     (doesn't run the installer if this variable is set to `true`)
*   `archiva_admin` - The object that describes the admin user
    *   `username`
    *   `password`
    *   `email`
    *   `fullName`
    *   `locked`
    *   `passwordChangeRequired`
    *   `permanent`
    *   `readOnly`
    *   `validated`

*   `archiva_repositories` - List of objects that describe managed repositories to create
    *   `id`
    *   `name`
    *   `layout`
    *   `indexDirectory`
    *   `description`
    *   `location`
    *   `snapshots`
    *   `releases`
    *   `blockRedeployments`
    *   `cronExpression`
    *   `stagingRepository`
    *   `scanned`
    *   `daysOlder`
    *   `retentionCount`
    *   `deleteReleasedSnapshots`
    *   `stageRepoNeeded`
    *   `resetStats`
    *   `skipPackedIndexCreation`

*   `archiva_users` - List of objects that describe users to create
    *   `username`
    *   `password`
    *   `email`
    *   `fullName`
    *   `locked`
    *   `passwordChangeRequired`
    *   `permanent`
    *   `readOnly`
    *   `validated`
    *   `assignedRoles` - List of strings of the roles. See `tests/example-playbook.yml`.


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

- hosts: all
  become: yes
  roles:
    - role: ansible-role-archiva
      archiva_admin:
        username: admin
        password: adminPass123
        email: admin@archiva-test.org
        fullName: Admin
        locked: false
        passwordChangeRequired: false
        permanent: false
        readOnly: false
        validated: true
      archiva_repositories:
      - id: myRepo
        name: myRepo
        layout: default
        indexDirectory: ./myRepo/.indexer
        description: null
        location: ./repositories/myRepo
        snapshots: false
        releases: true
        blockRedeployments: true
        cronExpression: '0 0 * * * ?'
        stagingRepository: null
        scanned: true
        daysOlder: 100
        retentionCount: 2
        deleteReleasedSnapshots: false
        stageRepoNeeded: false
        resetStats: false
        skipPackedIndexCreation: false
      archiva_users:
      - username: deploy
        password: deployPass123
        email: deploy@archiva-test.org
        fullName: Deploy User
        locked: false
        passwordChangeRequired: false
        permanent: false
        readOnly: false
        validated: true
        assignedRoles:
          - "Global Repository Manager"
          - "Global Repository Observer"
          - "Registered User"
          - "Repository Manager - internal"
          - "Repository Observer - internal"
          - "Repository Observer - snapshots"
          - "Repository Manager - snapshots"
```

License
-------

MIT

Author Information
------------------

[https://github.com/sperka](https://github.com/sperka)
