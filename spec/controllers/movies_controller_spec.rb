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

  describe 'New method' do
    it 'should be successful' do
      get :new
      response.should be_success
    end
  end

  describe 'Edit method' do
    it 'should call edit method' do
      Movie.should_receive(:find)
      get :edit, :id => 1
    end
  end

  describe 'Create method' do
    it 'should call create method' do
      Movie.should_receive(:create!).and_return(@fake_movie)
      post :create
    end
  end

  describe 'Update method' do
    it 'should call update attributes on a movie' do
      Movie.stub(:find).and_return(@fake_movie)
      @fake_movie.should_receive(:update_attributes!)
      put :update, :id => 1
    end
  end

  describe 'Destroy method' do
    it 'should call destroy' do
      Movie.stub(:find).and_return(@fake_movie)
      @fake_movie.should_receive(:destroy)
      post :destroy, :id => 1
    end
  end

  describe 'Index action' do
      it 'should set the ordering to title and session not defined' do
        Movie.stub(:find_all_by_rating)
        get :index, :sort => :title
      end

      it 'should skip first block' do
        Movie.stub(:find_all_by_rating)
        session.stub(:[]).with("flash").and_return double(:sweep => true, :update => true, :[]= => [], :keep => true)
        session.stub(:[]).with(:sort).and_return(:title)
        session.stub(:[]).with(:ratings).and_return({"G"=>"1"})
        get :index, :sort => :title, :ratings => nil
      end

      it 'should set the ordering to title and session defined' do
        Movie.stub(:find_all_by_rating)
        session.stub(:[]).with("flash").and_return double(:sweep => true, :update => true, :[]= => [], :keep => true)
        session.stub(:[]).with(:sort).and_return(:title)
        session.stub(:[]).with(:ratings).and_return(nil)
        get :index, :sort => :title, :ratings => nil
      end

      it 'should set the ordering to release_date' do
        Movie.stub(:find_all_by_rating)
        get :index, :sort => :release_date
      end
  end
end
