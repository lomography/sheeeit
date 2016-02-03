# Sheeeit

Sheeeit will take data in the form of arrays of arrays, e.g. ``[["Name", "Computer", "Pet"], ["Martin", "C64", "Rock"], ["Alice", "IBM PC Compatible", "Dog"], ["Fred", "IBM System/360", "Mammoth"]]`` and write it into the worksheet of a Google Docs spreadsheet. In addition, if wanted, it will keep an overview worksheet which keeps track of the last update of every single worksheet.


The hard work of connecting to Google Drive and actually altering spreadsheets is done by the awesome [https://github.com/gimite/google-drive-ruby](google-drive-ruby) gem. This gem just provides a more convenient way to (re)write a whole worksheets in one go (and optionally keeping an overview of all the worksheets).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sheeeit', git: 'git@github.com:lomography/sheeeit.git'
```
 and then ``bundle``, as usual. This gem is not released on rubygems, so please use github to install.

## Setup

There are two things you need to configure: access to Google Docs and the gem itself.

### Gem
Sheeeit will automatically pickup a ``config/sheeeit.yml`` configuration file in which you can set a few things.

```yaml
---
google_auth: 'config/sheeeit.json'
spreadsheet_key: 'some-key'
worksheet_name: 'some-name'

overview: true
overview_header:
  - Application
  - Last Updated At
```

Alternatively, you can also use an initializer instead of the config file.

```ruby
Sheeeit.configure do |config|
  config.spreadsheet_key = 'some-key'
  config.worksheet_name  = 'some-name'
end
```

The following keys are required for everything to work:
* ``google-auth``: Path to an authentication json file. Defaults to ``config/sheeeit.json`` and will be autocreated if it doesn't exist.
* ``spreadsheet_key``: The key to the spreadsheet you want to write to. You can find the key of the spreadsheet by opening the spreadsheet in google docs. The url should look like ``https://docs.google.com/spreadsheets/d/<spreadsheet_key>/edit#``
* ``worksheet_name``: Give a name to your worksheet.

### Google Docs Auth

After setting up the gem, if you run ``Sheeeit.write_spreadsheet`` without a authentication file, you will be prompted something like this:

```
1. Open this page:
https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=<SNIP>

2. Enter the authorization code shown in the page:
```

Just log into google and grant Sheeeit access to your spreadsheets. The needed information will then be writen into a file and no further authorization should be needed.

## Usage

Once everything is configured, usage is rather straightforward:

    # write data into google doc
    Sheeeit.write_spreadsheet [["Name", "Age", "Awesome"], ["Frank", 31, true]]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Tests are mostly built on mocking the interface provided by [https://github.com/gimite/google-drive-ruby](google-drive-ruby) and ensuring Sheeeit is calling the right methods, since we don't want to actually connect to Google Drive while testing.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lomography/sheeeit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
