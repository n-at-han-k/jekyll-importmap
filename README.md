# jekyll-importmap
A plugin that implementing importmaps for jekyll

## KNOWN ISSUE
Currently uses the `url` and `baseurl` properties to generate the resource urls. This means that you must follow a workaround during development. [See more information on the workaround here](i1)

## How it works
Heavily borrowed from the `importmap-rails` gem (a lot of parts copied), minus the `rails` parts and simplified to make a lot easier to understand.

## Usage
To be continued...

### Setup
Add to `Gemfile` via bundler
```sh
bundle add jekyll-importmap
```

Add to your `_config.yml`
```yaml
  plugins:
    - jekyll-importmap
```

Add to your layout
```
<html>
    <head>
        {% importmap %}
    </head>
...
```

### Importmap config
To be continued...

## Contributing
You're actively encouraged to create issues and pull requests.
