class Person < ActiveRecord::Base
  simple_column_search :first_name, :last_name, :alias

end