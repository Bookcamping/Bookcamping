Feature: Backend scoped by camp
  In order to separate different camps
  As a #bookcamping admin
  I only want to see my camp assets

  Background:
    Given a camp named "Camp1"
    And a book titled "Book1"
    And a camp named "Camp2"
    And a book titled "Book2"

  @current
  Scenario: Show references only on my camp
    Given I'm authenticated as "Admin"
    And I'm an admin
    And I'm at camp "Camp1"
    When I go to backend references
    Then I should see "Book1"
    And I should not see "Book2"


