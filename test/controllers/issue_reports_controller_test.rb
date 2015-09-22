require 'test_helper'

class IssueReportsControllerTest < ActionController::TestCase
  setup do
    @issue_report = issue_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issue_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issue_report" do
    assert_difference('IssueReport.count') do
      post :create, issue_report: {  }
    end

    assert_redirected_to issue_report_path(assigns(:issue_report))
  end

  test "should show issue_report" do
    get :show, id: @issue_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issue_report
    assert_response :success
  end

  test "should update issue_report" do
    patch :update, id: @issue_report, issue_report: {  }
    assert_redirected_to issue_report_path(assigns(:issue_report))
  end

  test "should destroy issue_report" do
    assert_difference('IssueReport.count', -1) do
      delete :destroy, id: @issue_report
    end

    assert_redirected_to issue_reports_path
  end
end
