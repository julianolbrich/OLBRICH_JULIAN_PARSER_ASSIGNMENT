require "application_system_test_case"

class FlatsTest < ApplicationSystemTestCase

#   test "something on object" do
#     # setup     -> i.e. have models in place
#     # exercise  -> do the thing that you want to execute
#     # verify    -> where you compare two things, is this what i expected?
#     # teardown  -> remove tests that you don't us
#   end

  test "visiting the home page with flats displayed" do
    visit root_path
    save_and_open_screenshot

    assert_selector "h5", text: "HOMEDAY ASSIGNMENT"
  end

  # test "visiting the index" do
  #   visit root_path
  #   assert_selector "h5", text: "Flats"
  # end

  # test "creating a Flat" do
  #   visit flats_url
  #   click_on "New Flat"

  #   fill_in "City", with: @flat.city
  #   fill_in "Country", with: @flat.country
  #   fill_in "District", with: @flat.district
  #   fill_in "State", with: @flat.state
  #   fill_in "Street", with: @flat.street
  #   fill_in "Street number", with: @flat.street_number
  #   click_on "Create Flat"

  #   assert_text "Flat was successfully created"
  #   click_on "Back"
  # end

  # test "destroying a Flat" do
  #   visit flats_url
  #   page.accept_confirm do
  #     click_on "Delete", match: :first
  #   end

  #   assert_text "Flat was successfully destroyed"
  # end
end
