class MoviesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    def index
        @movies = Movie.all
      end

    def show
        @movie = Movie.find(params[:id])
        @reviews = @movie.reviews
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        @movie.user = current_user
        if @movie.save
            redirect_to movies_path
        else
            render :new
        end
    end

    def edit
        @movie = Movie.find(params[:id])
    end

    def update
        @movie = Movie.find(params[:id])
        @movie.user = current_user
        if @movie.update(movie_params)
            redirect_to movies_path
            flash[:notice] = 'Update Success'
        else
            render :edit
        end
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to movies_path
    end

    def favorite
        @movie = Movie.find(params[:id])
        if !current_user.is_collector_of?(@movie)
            current_user.favorite!(@movie)
            flash[:notice] = '收藏成功'
            # redirect_to movie_path(@movie)
        else
            flash[:alert] = '你已经收藏'
        end
        redirect_to movie_path(@movie)
    end

    private

    def movie_params
        params.require(:movie).permit(:title, :description)
    end
end
