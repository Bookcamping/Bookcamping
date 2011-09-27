Feature: Create Section
  In order to organize the library
  As a #bookcamping user
  I want to create library sections

  Scenario: Create a new section
    And I'm authenticated as "Kamen"
    When I go to new section page
    And I fill in "shelf[name]" with "MySection"
    And I fill in "shelf[description]" with "My section description"
    When I press "Guardar"
    Then I am on "MySection" section page
    Then I should see "MySection"
    Then I should see "My section description"