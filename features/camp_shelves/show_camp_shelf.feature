Feature: Show a camp's shelf
  In order to find some references in chaos
  As a #bookcamping user
  I want to see the camp shelf contents

  Background:
    Given I'm at camp "testcamping"

  Scenario: Show references in camp shelf
    Given a camp's shelf named "Cultura Libre"
    And a book titled "Código fuente" inside shelf "Cultura Libre"
    And a book titled "Zemos98" inside shelf "Cultura Libre"
    When I go to "Cultura Libre" camp's shelf page
    Then I should see "Código fuente"
    Then I should see "Zemos98"

