# jekyll-importmaps
A plugin that implementing importmaps for jekyll

## How it works
Heavily borrowed from the `importmap-rails` gem (basically copied), minus the `rails` parts.

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