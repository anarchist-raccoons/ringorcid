require 'test_helper'

class OrcidsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orcid = orcids(:one)
  end

  test "should get index" do
    get orcids_url
    assert_response :success
  end

  test "should get new" do
    get new_orcid_url
    assert_response :success
  end

  test "should create orcid" do
    assert_difference('Orcid.count') do
      post orcids_url, params: { orcid: {  } }
    end

    assert_redirected_to orcid_url(Orcid.last)
  end

  test "should show orcid" do
    get orcid_url(@orcid)
    assert_response :success
  end

  test "should get edit" do
    get edit_orcid_url(@orcid)
    assert_response :success
  end

  test "should update orcid" do
    patch orcid_url(@orcid), params: { orcid: {  } }
    assert_redirected_to orcid_url(@orcid)
  end

  test "should destroy orcid" do
    assert_difference('Orcid.count', -1) do
      delete orcid_url(@orcid)
    end

    assert_redirected_to orcids_url
  end
end
