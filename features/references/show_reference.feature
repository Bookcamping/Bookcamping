Feature: Show reference
  In order to view a reference
  As a visitor to #bookcamping
  I want to go to the show reference page

  Background:
    Given a camp's shelf named "Feminismos"
    Given a book titled "Teoría King Kong" inside shelf "Feminismos"

  Scenario: Visitor views a book
    When I go to "Teoría King Kong" reference page
    Then I should see "Teoría King Kong"
    And I should see "Feminismos"
