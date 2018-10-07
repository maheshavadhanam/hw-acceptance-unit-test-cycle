require 'rails_helper'

describe MoviesController do

    describe "#director" do
        it "find movies with the same director" do
            @movie_id="534"
            @movie=double('random movie', :director => 'Random Director')
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            expect(@movie).to receive(:check_similar_movies)
            get :director, {:id => @movie_id}
            expect(response).to render_template(:director)
        end
        it "should redirect index page" do
            @movie_id="1234"
            @movie=double('random movie').as_null_object
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :director, {:id => @movie_id}
            expect(response).to redirect_to(movies_path)
            
        end
    end
    describe "#update" do
        it "Should update movie params" do
            @movie_id = "Abc"
            @movie = double("Movie",:title => "random")
            @params = {:title => "random",:rating => "R", :director => "random"}
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            expect(@movie).to receive(:update_attributes!).and_return(nil)
            get :update, {:id => @movie_id, :movie => @params}
            expect(response).to redirect_to(movie_path(@movie))
        end
    end
    
    describe "#show" do
        it "Should show movie attributes" do
            @movie_id = "ijk"
            @movie = double("movie",:title => "random")
            expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
            get :show, {:id => @movie_id}
            expect(response).to render_template(:show)
        end
    end
end