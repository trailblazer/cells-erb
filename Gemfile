source "https://rubygems.org"

# Specify your gem's dependencies in cells-erb.gemspec
gemspec

gem "minitest-line"

case ENV["GEMS_SOURCE"]
  when "local"
    gem "cells", path: "../cells"
  # gem "erbse", path: "../erbse"
  when "github"
    gem "cells", github: "trailblazer/cells"
end
