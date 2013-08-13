require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "cannot access photos index if not logged in" do
    get :index
    assert_redirected_to new_session_path
  end

  test "new shows photo upload form" do
    login_as(:nick)
    get :new
    assert_response :ok
  end

  test "create should create a photo record in the db" do
    login_as(:nick)

    assert_difference "Photo.count" do
      post :create, photo: {title: "foo", description: "bar"}
    end

    photo = assigns(:photo)
    assert photo.user
    assert_redirected_to photo_path(photo)
  end

  test "show should find a photo and render some HTML" do
    get :show, id: photos(:one).id
    assert_response :success
    assert assigns(:photo)
  end
  
  test "search should find a photo" do
    
    photo = photos(:one)
    photo.title = "nice title"
    photo.save
    
    post :search, query: "nice title"
    
    search_results - assigns["results"]
    search_results_ids = search_results_map {|search_result|
      search_result.id }
    
    assert search_result_ids.include?(photo.id)
  end
end
