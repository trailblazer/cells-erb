# Cells::Erb

Proper ERB support for Cells using [Erbse](https://github.com/apotonick/erbse).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cells-erb'
```

This will register the `Erbse::Template` engine with Tilt for `.erb` files.

And that's all you need to do.

## Dependencies

This gem works with Tilt 1.4 and 2.0, and hence allows you to use it from Rails 3.2 upwards.