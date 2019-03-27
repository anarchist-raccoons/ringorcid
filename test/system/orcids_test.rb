require "application_system_test_case"

class OrcidsTest < ApplicationSystemTestCase
  setup do
    @orcid = orcids(:one)
  end

  test "visiting the index" do
    visit orcids_url
    assert_selector "h1", text: "Orcids"
  end

  test "creating a Orcid" do
    visit orcids_url
    click_on "New Orcid"

    click_on "Create Orcid"

    assert_text "Orcid was successfully created"
    click_on "Back"
  end

  test "updating a Orcid" do
    visit orcids_url
    click_on "Edit", match: :first

    click_on "Update Orcid"

    assert_text "Orcid was successfully updated"
    click_on "Back"
  end

  test "destroying a Orcid" do
    visit orcids_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Orcid was successfully destroyed"
  end
end
