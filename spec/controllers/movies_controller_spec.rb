require 'spec_helper'

describe MoviesController do
  before :each do
    @fake_movie = mock('Movie')

    @fake_movie.stub(:director).and_return(nil)

    @fake_movie.stub(:title).and_return(nil)
  end

  describe 'Find Movies by Same Director' do

    it 'should get the id from the request and get the movie from db' do
      Movie.should_receive(:find).and_return(@fake_movie)
      get :same_director, {:id => 1}
    end

    context 'movie has director' do
      it 'should call movie objects get_movies_by_same_director method' do
        fmovie1 = mock('Movie1')
        fmovie1.stub(:director).and_return("Bond")
        fmovie1.should_receive(:get_movies_by_same_director)

        Movie.stub(:find).and_return(fmovie1)

        get :same_director, {:id => 1}
      end
    end

    context 'movie has no director' do
      it 'should render show page' do
        Movie.stub(:find).and_return(@fake_movie)
#response.should render_template('show')

        get :same_director, {:id => 1}
      end
    end

  end
end
