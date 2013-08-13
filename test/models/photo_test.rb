require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test "search works" do
    photo = photos(:one)
    photo.title = "nice title"
    photo.save
    
    search_results = Photo.search_for "nice title"
    
    search_results_ids = search_results.map {|search_results|
      search_result.id }
    
    assert search_result_ids.include?(photo.id)
  end
end
