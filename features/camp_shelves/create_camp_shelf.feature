Feature: Create camp shelf
  In order to organize the camp library
  As a #bookcamping user
  I want to create a camp shelf

  Scenario: Create a new camp shelf
    And I'm authenticated as "Kamen"
    When I go to new camp shelf page
    And I fill in "camp_shelf[name]" with "MySection"
    And I fill in "camp_shelf[description]" with "My section description"
    When I press "Guardar"
    Then I am on "MySection" camp's shelf page
    Then I should see "MySection"
    Then I should see "My section description"