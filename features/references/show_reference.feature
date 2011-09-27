Feature: Show reference
  In order to view a reference
  As a visitor to #bookcamping
  I want to go to the show reference page

  Background:
    Given a book titled "Teoría King Kong"

  @wip
  Scenario: Visitor views a book
    When I go to "Teoría King Kong" reference page
    Then I should see "Teoría King Kong"
