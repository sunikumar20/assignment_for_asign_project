require 'test_helper'

class AssignProjectsControllerTest < ActionController::TestCase
  setup do
    @assign_project = assign_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assign_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assign_project" do
    assert_difference('AssignProject.count') do
      post :create, assign_project: { projects: @assign_project.projects, users: @assign_project.users }
    end

    assert_redirected_to assign_project_path(assigns(:assign_project))
  end

  test "should show assign_project" do
    get :show, id: @assign_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assign_project
    assert_response :success
  end

  test "should update assign_project" do
    patch :update, id: @assign_project, assign_project: { projects: @assign_project.projects, users: @assign_project.users }
    assert_redirected_to assign_project_path(assigns(:assign_project))
  end

  test "should destroy assign_project" do
    assert_difference('AssignProject.count', -1) do
      delete :destroy, id: @assign_project
    end

    assert_redirected_to assign_projects_path
  end
end
