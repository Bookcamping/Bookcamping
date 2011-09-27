Feature: Search references
  In order to find references
  As a #bookcamping user
  I want to search books

  @wip
  Scenario: Search by title
    Given a book titled 'One two three'
    When I go to dashboard page
    And I fill in "search-term" with "two"
    And press "search"
    Then I should see 'One two three'

  @wip
  Scenario: Search by author
    Given a booka titled 'The One' and 'author' is 'someone'
    When I go to dashboard page
    And I fill in 'search-term' with 'some'
    And press "search"
    Then I should see 'The One'