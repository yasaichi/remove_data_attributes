# remove\_data\_attributes
[![Gem Version](https://badge.fury.io/rb/remove_data_attributes.svg)](https://badge.fury.io/rb/remove_data_attributes)
[![Build Status](https://travis-ci.org/yasaichi/remove_data_attributes.svg?branch=master)](https://travis-ci.org/yasaichi/remove_data_attributes)
[![Maintainability](https://api.codeclimate.com/v1/badges/eddaa55a25ccd62b9eb8/maintainability)](https://codeclimate.com/github/yasaichi/remove_data_attributes/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/eddaa55a25ccd62b9eb8/test_coverage)](https://codeclimate.com/github/yasaichi/remove_data_attributes/test_coverage)

## Motivation
As described in [this post](https://blog.kentcdodds.com/making-your-ui-tests-resilient-to-change-d37a6ee37269), using data attributes as selector makes your UI tests more resilient to change.  
However, there is one little problem in this way: these attributes are useless when running your application in production.

## Solution (with limitations)
remove_data_attributes is a plugin for Ruby on Rails like [babel-plugin-react-remove-properties](https://github.com/oliviertassinari/babel-plugin-react-remove-properties) for Babel.  
Note that the plugin can remove __only the data attributes passed into the view helpers__, because there is no room to parse and remove all attributes (including ones embedded in HTML tags) in advance unlike the Babel plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'remove_data_attributes', group: :production
```

And then execute:
```bash
$ bundle
```

## Usage
Run the installation generator with:

```sh
$ rails generate remove_data_attributes:install
```

And then specify `data-*` attributes you'd like to remove in the generated configuration file:

```yaml
data_attributes:
  - data-testid
```

This will remove `data-testid` attributes.

## Example
Here is an example of removing `data-testid` attributes.

### Template
```ERB
<%= form_for :user, url: session_path(:user) do |f| %>
  <%= field_set_tag "Email" do %>
    <%= f.email_field :email, "data-testid": "email" %>
  <% end %>

  <%= field_set_tag "Password" do %>
    <%= f.password_field :password, "data-testid" => "password" %>
  <% end %>

  <%= f.submit "Sign in", data: { testid: "submit" } %>
<% end %>
```

### Rendered HTML (formatted for readability)
```html
<form action="/users/sign_in" accept-charset="UTF-8" method="post">
  <input name="utf8" type="hidden" value="&#x2713;" />
  <input type="hidden" name="authenticity_token" value="HyOvLlyjIh7Sv7fFt2fKy5+uJNeKwnYobQPs49pl/H7CKSAVrw57jxpERJihR+B77GNSh2pZHG5mEWl0ieYQnQ==" />

  <fieldset>
    <legend>Email</legend>
    <input type="email" value="" name="user[email]" id="user_email" />
  </fieldset>

  <fieldset>
    <legend>Password</legend>
    <input type="password" name="user[password]" id="user_password" />
  </fieldset>

  <input type="submit" name="commit" value="Sign in" data-disable-with="Sign in" />
</form>
```

## Contributing
You should follow the steps below:

1. [Fork the repository](https://help.github.com/articles/fork-a-repo/)
2. Create a feature branch: `git checkout -b add-new-feature`
3. Commit your changes: `git commit -am 'Add new feature'`
4. Push the branch: `git push origin add-new-feature`
4. [Send us a pull request](https://help.github.com/articles/about-pull-requests/)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
