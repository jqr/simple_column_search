require 'rubygems'
require 'activerecord'

module SimpleColumnSearch
  # Adds a Model.search('term1 term2') method that searches across SEARCH_COLUMNS
  # for ANDed TERMS ORed across columns.
  #   
  #  class User
  #    simple_column_search :first_name, :last_name
  #  end
  #  
  #  User.search('elijah')          # => anyone with first or last name elijah
  #  User.search('miller')          # => anyone with first or last name miller
  #  User.search('elijah miller')
  #    # => anyone with first or last name elijah AND
  #    #    anyone with first or last name miller
  def simple_column_search(*columns)
    named_scope :search, lambda { |terms|
      conditions = terms.split.inject(nil) do |acc, term|
        pattern = '%' + term + '%'
        merge_conditions  acc, [columns.collect { |column| "#{table_name}.#{column} LIKE :pattern" }.join(' OR '), { :pattern => pattern }]
      end
    
      { :conditions => conditions }
    }
  end
  
end
