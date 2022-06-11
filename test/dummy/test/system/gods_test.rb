require "application_system_test_case"

class GodsTest < ApplicationSystemTestCase
  setup do
    @god = gods(:one)
  end

  test "visiting the index" do
    visit gods_url
    assert_selector "h1", text: "Gods"
  end

  test "creating a God" do
    visit gods_url
    click_on "New God"

    click_on "Create God"

    assert_text "God was successfully created"
    click_on "Back"
  end

  test "updating a God" do
    visit gods_url
    click_on "Edit", match: :first

    click_on "Update God"

    assert_text "God was successfully updated"
    click_on "Back"
  end

  test "destroying a God" do
    visit gods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "God was successfully destroyed"
  end
end
