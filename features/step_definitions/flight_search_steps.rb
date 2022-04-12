Given(/^user is on the Cheapoair homepage$/) do
  visit CheapoairFlightPage
end

And(/^user search for (.*) city and select (.*) airport for departure$/) do |dep_city, dep_airport|
  on(CheapoairFlightPage).search_dep_airport dep_city, dep_airport
end

And(/^user search for (.*) city and select (.*) airport for arrival$/) do |arr_city, arr_airport|
  on(CheapoairFlightPage).search_arr_airport arr_city, arr_airport
end

And(/^user select future dates for departure$/) do
  on(CheapoairFlightPage).choose_dep_date 2
end

And(/^user select future dates for arrival$/) do
  on(CheapoairFlightPage).choose_arr_date 5
end

And(/^user searchs for available flights$/) do
  on(CheapoairFlightPage).select_flight_element.click
end

Then(/^verify user should see the available flights$/) do
  # on(CheapoairFlightResultPage).verify_flights
  actual_value = on(CheapoairFlightResultPage).get_flight_result_header
  on(CheapoairFlightResultPage).verify_expected_value_exists? actual_value, "results found"
  sleep 5
end

When(/^user search for the available flights for the futures dates$/) do
  on(CheapoairFlightPage).search_available_flights "Columbus", "CMH - Columbus, Ohio, United States", "Cleland", "CLE - Cleveland All Airports, Ohio, United State"

end

And(/^user leaves departure and arrival city fields blank$/) do
  # on(CheapoairFlightPage).suggestion_box_element.click if on(CheapoairFlightPage).suggestion_box_element.present?
  # on(CheapoairFlightPage).suggestion_box1_element.click if on(CheapoairFlightPage).suggestion_box1_element.present?

  on(CheapoairFlightPage) do |page|
    page.suggestion_box_element.click if page.suggestion_box_element.present?
    page.suggestion_box1_element.click if page.suggestion_box1_element.present?

  end
end

Then(/^user should see the following error messages:$/) do |table|
  # table is a table.hashes.keys # => [:Please entere a from city or airport]
  all_error_msgs = on(CheapoairFlightPage).get_all_error_message
  table.hashes.each do |each_error|
    current_error = each_error['error_messages']
    fail "#{current_error} message is not found in all the Errors -#{all_error_msgs}" unless all_error_msgs.include? each_error['error_messages']
  end
  p "hai"
end

And(/^flight search results are displayed with sort order of price$/) do
  all_prices = on(CheapoairFlightResultPage).get_all_flights_prices
  fail "Prices - #{all_prices} are not in Ascending Order - #{all_prices.sort}" unless all_prices == all_prices.sort
  #expect(all_prices).should be eq all_prices.sort
end

When(/^user search for the available flights for the futures dates with yml file$/) do
  pending
end