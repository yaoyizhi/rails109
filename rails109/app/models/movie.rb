class Movie < ApplicationRecord
    has_many :reviews
    belongs_to :user

    has_many :movie_relationships
    has_many :collectors, through: :movie_relationships, source: :user
end
