
Defaults 

```
MEDIA_WIKI_VERSION=${MEDIA_WIKI_VERSION:-"1.33"}
MEDIA_WIKI_SUB_VERSION=${MEDIA_WIKI_SUB_VERSION:-"0"}
MEDIA_WIKI_NAME=${MEDIA_WIKI_NAME:-"mStakX"}
MEDIA_WIKI_USER=${MEDIA_WIKI_USER:-"mediawiki"}
MEDIA_WIKI_PASS=${MEDIA_WIKI_PASS:-"mediawiki"}
MEDIA_WIKI_DB_USER=${MEDIA_WIKI_DB_USER:-"mediawiki"}
MEDIA_WIKI_DB_PASS=${MEDIA_WIKI_DB_PASS:-"mediawiki"}
MEDIA_WIKI_INSTALL_DB_USER=${MEDIA_WIKI_INSTALL_DB_USER:-"root"}
MEDIA_WIKI_INSTALL_DB_PASS=${MEDIA_WIKI_INSTALL_DB_PASS:-"password"}
MEDIA_WIKI_DB_TYPE=${MEDIA_WIKI_DB_TYPE:-"mysql"}
MEDIA_WIKI_DB_NAME=${MEDIA_WIKI_DB_NAME:-"mstakx"}
MEDIA_WIKI_DB_SERVER=${MEDIA_WIKI_DB_SERVER:-"mysql"}
MEDIA_WIKI_LOGO=${MEDIA_WIKI_LOGO:-"https://raw.githubusercontent.com/ansilh/mediawiki-installer/master/linxlabs.png"}
```

You may customize the paramters using below environmental varaibles in `InitContainer`

```yaml
        env:
        - name: MEDIA_WIKI_VERSION
          value: "1.33"
        - name: MEDIA_WIKI_SUB_VERSION
          value: "0"
        - name: MEDIA_WIKI_NAME
          value: "mStakX"
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
          value: "mstakx"
        - name: MEDIA_WIKI_DB_SERVER
          value: "mysql"
```