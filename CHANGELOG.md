# Next version
+ Remove Docker implementation (not completed)
+ Remove config folder (for old Docker)
+ Add Dockerfile

## 4.2.0
+ Add hook-chaining support
+ Improve logging/error messages

## 4.1.2
+ Fix #72

## 4.1.1
+ Fix instructions for crontab

## 4.1.0
+ Update Docker instructions
+ Update error codes
+ Add support for using API tokens instead of email+global API key

## 4.0.0

### Add
+ Add dependency for `jq`

### Fix
+ Fix "method_not_allowed"

## 3.1.1

### Fix
+ Fix missin DOCKER_API_TOKEN

## 3.1.0

### Add
+ Add `Docker`
+ Add `Travis`

## 3.0.0

### Refactor
+ Renamed branch from `development` to `develop`
+ Improved `hook.sh` looking for config.sh files
+ Changed instructions (no more need to put cfhookbash as subfolder of dehydrated)

## 2.4.3
+ Missing remove file.

## 2.4.2
+ Fix #36 error
```bash
{
"code": 1001,
"error": "method_not_allowed"
}}
```

## 2.4.1
+ Close #16
+ Add Common error messages on README.md

## 2.4.0
+ Fix #28
+ Update README.md (Disable ACME v1 registrations)
+ Update year license

##2.3.1
+ Fix #27

##2.2.1
+ Fix #15

##2.2.0
+ Fix #5
+ Fix #9
+ Fix typo in README.md
+ Clean branch
+ Add contributors
+ Add CONTRIBUTING.md
+ Add CHANGELOG.md
+ Refactor .gitignore

##2.1.0
Stable branch
