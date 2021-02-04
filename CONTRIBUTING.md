# Contributing

Contributions are **welcome** and will be fully **credited**. This page details how to 
contribute and the expected code quality for all contributions.

## ACME stage url

Create a `config` file in same folder of `./dehydrated` with following content, to no hit Let's Encrypt limits.

Warning! Use this ONLY during development, not in production!

``` shell
CA="https://acme-staging-v02.api.letsencrypt.org/directory"
```


## Pull Requests

We accept contributions via Pull Requests.

- **Document any change in behaviour** - Make sure the `README.md` and any other relevant documentation are kept up-to-date.

- **Consider our release cycle** - We try to follow [SemVer v2.0.0](http://semver.org/). Randomly breaking public APIs is not an option.

- **Create feature branches** - Don't ask us to pull from your master branch.

   - Create a branch `feature-myawesomefeature` or `hotfix-myhotfix` from `develop`
   - Push your branch against `develop` branch.
   - Update `CHANGELOG.md` under a `#Next version` section

- **One pull request per feature** - If you want to do more than one thing, send multiple pull requests.

- **Send coherent history** - Make sure each individual commit in your pull request is meaningful. If you had to make multiple intermediate commits while developing, please [squash them](http://www.git-scm.com/book/en/v2/Git-Tools-Rewriting-History#Changing-Multiple-Commit-Messages) before submitting.
 
**Happy coding**!
