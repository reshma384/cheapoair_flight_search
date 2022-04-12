class CheapoairFlightPage
  include PageObject
  page_url "www.cheapoair.com"

  link(:suggestion_box, class: 'suggestion-box__clear icon', index: 0)
  text_field(:dep_airport_field, id: 'from0')
  unordered_list(:all_suggestion_airport, class: 'suggestion-box__list autoSuggest__list')
  link(:suggestion_box1, class: 'suggestion-box__clear icon', index: 1)
  text_field(:arr_airport_field, id: 'to0')
  unordered_list(:all_suggestion_airport1, class: 'suggestion-box__list autoSuggest__list', index: 1)
  div(:dep_date,class: 'col-6 calendarDepart')
  div(:arr_date, class: 'col-6 calendarReturn')
  button(:select_flight, class: 'btn btn-lg btn-block btn-default btn-search')
  list_items(:all_error_msg, class: 'alerts__item')

  def get_all_error_message
    get_all_error_message_element.map(&:text)
  end

  def search_dep_airport dep_city, dep_airport
    suggestion_box_element.click if suggestion_box_element.present?
    dep_airport_field_element.set dep_city
    #self.dep_airport_field = dep_city
    sleep 2
    all_suggestion_airport_element.lis.each do |each_airport|
      if each_airport.text.include? dep_airport
        each_airport.click
        break
      end
    end
    sleep 1
  end

  def search_arr_airport arr_city, arr_airport
    # @browser.link(class: 'suggestion-box__clear icon', index: 1).click if @browser.link(class: 'suggestion-box__clear icon', index: 1).present?
    suggestion_box1_element.click if suggestion_box1_element.present?

    # @browser.text_field(id: 'to0').set arr_city
    arr_airport_field_element.set arr_city
    sleep 2
    # @browser.ul(class: 'suggestion-box__list autoSuggest__list', index: 1).lis.each do |each_airport|
    all_suggestion_airport1_element.lis.each do |each_airport|
      if each_airport.text.include? arr_airport
        each_airport.click
        break
      end
    end
    sleep 1
  end

  def cal_date no_of_days
    (Time.now + 24*60*60*no_of_days).strftime("%-d %B %Y")
  end

  #departure Date
  def choose_dep_date no_of_days
    exact_date = cal_date no_of_days
    dep_date_element.click
    @browser.link(aria_label: exact_date).click
  end

  #Return Date
  def choose_arr_date no_of_days

    exact_date = cal_date no_of_days
    # @browser.div(class: 'col-6 calendarReturn').click
    # @browser.link(aria_label: exact_date).click
    arr_date_element.click
    @browser.link(aria_label: exact_date).click
  end

  def search_available_flights dep_city, dep_airport, arr_city, arr_airport

    search_dep_airport dep_city, dep_airport
    search_arr_airport arr_city, arr_airport
    choose_dep_date 2
    choose_arr_date 5
    select_flight_element.click

  end

end
