require "test_helper"

class TripsTest < ActionDispatch::IntegrationTest
  test "user can see their trips" do
    user = login_a_user
    trip1 = FactoryBot.create :trip, user: user
    trip2 = FactoryBot.create :trip, user: user
    trip3 = FactoryBot.create :trip # different user

    visit trips_path

    assert_text trip1.title
    assert_text trip2.title
    assert_text trip3.title
  end

  test "user can create their trip" do
    login_a_user
    visit new_trip_path

    trip_title = "Autumn Escape"

    assert_difference "Trip.count", 1 do
      fill_in "Title", with: trip_title
      fill_in "Destination", with: "Lisbon"
      fill_in "Start date", with: Date.current.to_s
      fill_in "End date", with: 1.week.from_now.to_date.to_s
      fill_in "Description", with: "A week-long adventure exploring the coast."

      click_button "Create Trip"
    end

    assert_text "Trip was successfully created."
    assert_text trip_title
  end

  test "user can view and update their trip" do
    user = login_a_user
    trip = FactoryBot.create :trip, user: user, title: "Spring Retreat"

    visit trip_path(trip)
    assert_text trip.title

    click_link "Edit Trip"

    updated_title = "Summer Retreat"
    fill_in "Title", with: updated_title
    fill_in "Description", with: "Updated description for the newly planned getaway."
    click_button "Update Trip"

    assert_text "Trip was successfully updated."
    assert_text updated_title
  end

  test "trip update shows validation errors" do
    user = login_a_user
    trip = FactoryBot.create :trip, user: user, title: "Winter Escape"

    visit edit_trip_path(trip)

    fill_in "Title", with: ""
    click_button "Update Trip"

    assert_text "can't be blank"
    assert_equal "Winter Escape", trip.reload.title
  end

  test "user can delete their trip" do
    user = login_a_user
    trip = FactoryBot.create :trip, user: user, title: "Weekend Getaway"

    visit trip_path(trip)
    assert_text trip.title

    assert_difference "Trip.count", -1 do
      if Capybara.current_driver == :rack_test
        page.driver.submit :delete, trip_path(trip), {}
      else
        accept_confirm do
          click_link "Delete Trip"
        end
      end
    end

    assert_text "Trip was successfully deleted."
    refute_text trip.title
  end
end
