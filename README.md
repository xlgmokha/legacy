# README

This is an example rails application that connects to multiple
databases.


The work on this repository is based on the following posts:

* http://www.ostinelli.net/setting-multiple-databases-rails-definitive-guide/
* https://technology.customink.com/blog/2015/06/22/rails-multi-database-best-practices-roundup/

I encourage readers to also view the keynote by Eileen Uchitelle to
learn about exciting changes coming to [Rails 6](http://confreaks.tv/videos/railsconf2018-keynote-the-future-of-rails-6-scalable-by-default).

In this example we have two databases:

* db/development.sqlite3
* db_legacy/development.sqlite3

The `db/development.sqlite3` represents a new database that this
application is migrating to. `db_legacy/development.sqlite3` represents
the legacy database that this application is migrating away from.

The legacy database has a single model named `Business` and the new
database has a single model named `Organization`.

To control two different connection pools we have two [Layer
Supertypes](https://martinfowler.com/eaaCatalog/layerSupertype.html).
One called `LegacyRecord` and the other is `ApplicationRecord`.

```ruby
class LegacyRecord < ActiveRecord::Base
  establish_connection Rails.configuration.x.legacy[Rails.env]
  self.abstract_class = true
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
```

Any classes that inherit from `LegacyRecord` join the legacy database
connection pool. The `LegacyRecord` establishes a connection to the
legacy database using the `Rails.configuration.x.legacy` configuration
which is loaded in an initializer.


```ruby
Rails.configuration.x.legacy = YAML.load(ERB.new(IO.read(Rails.root.join("config","database_legacy.yml"))).result)
```

The initializer above loads the file `config/database_legacy.yml` which
contains the connection information to connect to the legacy database.


Migrations for the new database are put in the `db/migrate` folder just
like any other rails application. Migrations that need to run against
the legacy database are put in `db_legacy/migrate' and can be run using
the rake tasks defined in `lib/tasks/legacy.rake`.

By moving the legacy database related code to the `legacy.rake` file and
the `db_legacy`, we make it easier to clean up when we finally decouple
from the legacy database.

The primary database connection information is still read from
`config/database.yml`.
