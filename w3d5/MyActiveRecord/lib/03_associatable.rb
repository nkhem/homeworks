require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    self.model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    name = name.to_s

    defaults = {
      class_name: "#{name.singularize.camelcase}",
      primary_key: :id,
      foreign_key: "#{name.singularize.underscore}_id".to_sym
    }

    defaults.keys.map do |key|
      send("#{key}=", options[key] || defaults[key])
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    name, self_class_name = name.to_s, self_class_name.to_s

    defaults = {
      class_name: "#{name.singularize.camelcase}",
      primary_key: :id,
      foreign_key: "#{self_class_name.singularize.underscore}_id".to_sym
    }

    defaults.keys.map do |key|
      send("#{key}=", options[key] || defaults[key])
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {}) # belongs_to :human, foreign_key: :owner_id
    opts = BelongsToOptions.new(name, options)

    define_method(name) do #name == :human
      forn_key = self.send(opts.foreign_key) #:owner_id => INTEGER
      prim_key = self.send(opts.primary_key) #:id

      opts
        .model_class #Human
        .where(prim_key => forn_key)
        .first
    end
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
