
Defaults are self explanatory .

```
MEDIA_WIKI_VERSION=${MEDIA_WIKI_VERSION:-"1.33"}
MEDIA_WIKI_SUB_VERSION=${MEDIA_WIKI_SUB_VERSION:-"0"}
MEDIA_WIKI_NAME=${MEDIA_WIKI_NAME:-"LinxLabs"}
MEDIA_WIKI_USER=${MEDIA_WIKI_USER:-"Admin"} # User name will start with caps even if you provide small
MEDIA_WIKI_PASS=${MEDIA_WIKI_PASS:-"P@ssw0rd1234"} # Minimum 8 characters with special cap/special/number combination
MEDIA_WIKI_DB_USER=${MEDIA_WIKI_DB_USER:-"mediawiki"}
MEDIA_WIKI_DB_PASS=${MEDIA_WIKI_DB_PASS:-"mediawiki"}
MEDIA_WIKI_INSTALL_DB_USER=${MEDIA_WIKI_INSTALL_DB_USER:-"root"}
MEDIA_WIKI_INSTALL_DB_PASS=${MEDIA_WIKI_INSTALL_DB_PASS:-"password"}
MEDIA_WIKI_DB_TYPE=${MEDIA_WIKI_DB_TYPE:-"mysql"}
MEDIA_WIKI_DB_NAME=${MEDIA_WIKI_DB_NAME:-"linxlabs"}
MEDIA_WIKI_DB_SERVER=${MEDIA_WIKI_DB_SERVER:-"mysql"}
MEDIA_WIKI_LOGO=${MEDIA_WIKI_LOGO:-"https://raw.githubusercontent.com/ansilh/mediawiki-installer/master/linxlabs.png"}
```

You may customize the parameters using below environmental variables in `InitContainer`

```yaml
        env:
        - name: MEDIA_WIKI_VERSION
          value: "1.33"
        - name: MEDIA_WIKI_SUB_VERSION
          value: "0"
        - name: MEDIA_WIKI_NAME
          value: "LinxLabs"
        - name: MEDIA_WIKI_USER
          value: "Admin"
        - name: MEDIA_WIKI_PASS
          value: "P@ssw0rd1234"
        - name: MEDIA_WIKI_DB_USER
          value: "mediawiki"
        - name: MEDIA_WIKI_DB_PASS
          value: "mediawiki"
        - name: MEDIA_WIKI_INSTALL_DB_USER
          value: "root"
        - name: MEDIA_WIKI_INSTALL_DB_PASS
          value: "password"
        - name: MEDIA_WIKI_DB_TYPE
          value: "mysql"
        - name: MEDIA_WIKI_DB_NAME
          value: "linxlabs"
        - name: MEDIA_WIKI_DB_SERVER
          value: "mysql"
```