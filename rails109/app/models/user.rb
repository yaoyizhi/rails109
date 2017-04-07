class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :reviews
    has_many :movies
    has_many :movie_relationships
    has_many :favorite_movies, through: :movie_relationships, source: :movie

    def is_collector_of?(movie)
        favorite_movies.include?(movie)
    end

    def favorite!(movie)
        favorite_movies << movie
    end
end
