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
    assert_selector ".address", count: Flat.count
  end


  # test 'with postal code and city' do
  #   let(:params) { 'address=10119 Berlin' }
  #   it 'returns postal code, city, state and country' do
  #     expected = {
  #       'postal_code' => '10119',
  #       'city' => 'Berlin',
  #       'district' => 'Mitte',
  #       'country' => 'Germany'
  #     }

  #     expect(json_body).to eq expected
  #     expect(last_response.status).to eq 200
  #   end
  # end


end
