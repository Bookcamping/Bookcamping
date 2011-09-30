Feature: Create a new reference
  In order to share the things I love
  As a #bookcamping user
  I want to add a reference to #bookcamping

  Background:
    Given a camp named "#bookcamping"
    And a license named "Public domain"
    And a camp's shelf named "Cajón"
    And I'm authenticated as "Jess"

  Scenario: Create a new reference
    When I go to new reference page
    And I select "Cajón" from "book[include_in_shelf_id]"
    And fill in "book[title]" with "Codigo fuente: la remezcla"
    And I select "Public domain" from "book[license_id]"
    And press "Guardar"
    Then I should be on "Codigo fuente: la remezcla" reference page
    And I should see "Codigo fuente: la remezcla"
    And I should see "Cajón"
