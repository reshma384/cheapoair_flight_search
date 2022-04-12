Feature: Cheapoair Flight search functionality

  Scenario: 1verify user is able to search for the available flights for a future dates
    Given user is on the Cheapoair homepage
    When user search for Columbus city and select CMH - Columbus, Ohio, United States airport for departure
    And user search for Cleveland city and select CLE - Cleveland All Airports, Ohio, United States airport for arrival
    And user select future dates for departure
    And user select future dates for arrival
    And user searchs for available flights
    Then verify user should see the available flights

    #Declarative style
  Scenario: 2verify user is able to search for the available flights for a future dates in Declarative style
    Given user is on the Cheapoair homepage
    When user search for the available flights for the futures dates
    Then verify user should see the available flights

    #Ymal style
  Scenario: 2verify user is able to search for the available flights for a future dates using in Ymal file
    Given user is on the Cheapoair homepage
    When user search for the available flights for the futures dates with yml file
    Then verify user should see the available flights

    #nagative cases
  Scenario: verify user is able to validate the mandartory search fields for All the flield for Flights search
    Given user is on the Cheapoair homepage
    And user leaves departure and arrival city fields blank
    And user select future dates for departure
    And user select future dates for arrival
    And user searchs for available flights
    Then user should see the following error messages:
      | error_messages                        |
      | Please entere a from city or airport. |
      | Please entere a to city or airport.   |


  Scenario Outline: 3verify user is able to search for the available flights for a future dates for different locations
    Given user is on the Cheapoair homepage
    And user search for <dep_city_name> city and select <dep_airport_name> airport for departure
    And user search for <arr_city_name> city and select <arr_airport_name> airport for departure
    And user select future dates for departure
    And user select future dates for arrival
    And verify user should see the available flights
    Then verify user should see the available flights

    Examples:
      | dep_city_name | dep_airport_name                                    | arr_city_name | arr_airport_name                                   |
      | Columbus      | CMH - Columbus, Ohio, United States                 | Cleveland     | CLE - Cleveland All Airports, Ohio, United States  |
      | chicago       | CHI - Chicago All Airports, Illinois, United States | orlando       | ORL - Orlando All Airports, Florida, United States |

  Scenario: validate the flight search results are displayed with sort order of price
    Given user is on the Cheapoair homepage
    When user search for the available flights for the futures dates
    Then verify user should see the available flights
    And flight search results are displayed with sort order of price