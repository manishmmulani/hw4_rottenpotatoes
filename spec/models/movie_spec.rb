require 'spec_helper'

describe Movie do

  describe 'Get Movies by same director' do
    it 'should call Movies find_all_by_director method' do
      movie = Movie.new({:title => "hello", :director => "bond"})
      Movie.should_receive(:find_all_by_director).with("bond")
      movie.get_movies_by_same_director
    end
  end

end
