# jekyll-importmap
A plugin that implementing importmaps for jekyll


## How it works
Heavily borrowed from the `importmap-rails` gem (a lot of parts copied), minus the `rails` parts and simplified to make a lot easier to understand.


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

Create your importmap.rb file in the root directory
```ruby
pin 'application', to: 'assets/js/application.js', preload: true
```

### During Development
During development you must set a url to use as an override instead of using `url` and `baseurl`
```yaml
importmap:
  devurl: 'https://127.0.0.1:4000/jekyll-importmap'
```

When committing to production comment it out!
```yaml
# importmap:
    devurl: 'https://127.0.0.1:4000/jekyll-importmap'
```

### Importmap config
Uses the exact same syntax as the `importmap-rails` gem.

## Usage
This plugin creates a javascript importmap and also an import statement that looks for a module called `application`.
Make sure that you have added this to your importmap. This is the entry point of your application and you can import everything from here.
```ruby
pin 'application', to: 'assets/js/application.js', preload: true
```

And don't forget to specify `to` and `under` when using `pin_all_from`
```ruby
pin_all_from "assets/js/controllers", to: "assets/js/controllers", under: "controllers"
```

### Example for StimulusJS
#### importmap.rb
```ruby
pin 'application', to: 'assets/js/application.js', preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js", preload: true
pin "@hotwired/stimulus-loading", to: "assets/js/stimulus-loading.js", preload: true
pin_all_from "assets/js/controllers", to: "assets/js/controllers", under: "controllers"
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/esm/index.js"
pin "stimulus-flatpickr", to: "https://ga.jspm.io/npm:stimulus-flatpickr@3.0.0-0/dist/index.m.js"
```

#### assets/js/application.js
```javascript
import 'controllers'
```

#### assets/js/controllers/index.js
```javascript
import { Application } from "@hotwired/stimulus"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import Flatpickr from 'stimulus-flatpickr'

const application = Application.start()
application.register('flatpickr', Flatpickr)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
eagerLoadControllersFrom("controllers", application)
```

#### assets/js/controllers/flatpickr_controller.js
```javascript
import { Controller } from "@hotwired/stimulus"
import Flatpickr from 'stimulus-flatpickr'

// Connects to data-controller="flatpickr"
export default class extends Flatpickr {
  connect() {
    this.config = {
      plugins: [],
      enableTime: true,
    }
    super.connect()
  }
}
```

#### assets/js/stimulus-loading.js
```
// content from https://github.com/hotwired/stimulus-rails/blob/ae4b675473b71fdf01530c8a6a3bb277d3388ee2/app/assets/javascripts/stimulus-loading.js
```

#### index.html
```html
<div data-controller="flatpickr"></div>
```

## Contributing
You're actively encouraged to create issues and pull requests.
