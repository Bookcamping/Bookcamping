Feature: Home Page
  As a visitor to Bookcamping
  I want a homepage to greet me and tell me useful things

  Background:
    Given a camp named "bookcamping"

  Scenario: Unauthenticated visitor sees home page
    When I am on the home page
    Then I should see "bookcamping"
    #Then I should see "Entrar con twitter"


