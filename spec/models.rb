class Person < ActiveRecord::Base
  simple_column_search :first_name, :last_name, :alias

  simple_column_search :first_name, :name => :search_first_name
end