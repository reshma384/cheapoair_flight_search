class CheapoairFlightResultPage
  require_relative '../modules/utility_modules'
  include PageObject
  include UtilityModules

  div(:result_header, class: 'filters--content col-12 p-0')

  def get_flight_result_header
    result_header_element.when_present(45).text
  end

  def verify_flights
    # filter_section = @browser.div(class: 'filters--content col-12 p-0')
    # p filter_section
    # sleep 2
    # @browser.wait_until(45){result_header_element.exist?}
    fail "Flight search results not found" unless result_header_element.when_present(45).text.include? "results found"
  end

  def get_all_flights_prices
    @browser.li(class: 'col p-0 sort-tab__item is--tab-cheapest ').click
    sleep 1
    #@browser.divs(class: 'fare-details__fare').map(&:text)
    all_prices = []

    @browser.divs(class: 'fare-details__fare').each do |each_price|
      all_prices << each_price.text.gsub('$', '').gsub(',', '').to_i
    end

    all_prices
  end

end
