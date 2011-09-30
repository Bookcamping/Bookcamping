Feature: Create media bite

  Background:
    Given I'm at camp "testcamping"
    And I'm authenticated as "admin"
    And I'm an admin

    @current
    Scenario: Create media bite
      When I go to new admin media bite page
      And I fill in "media_bite[title]" with "MyMedia"
      And press "submit_media_bite"
      Then I should be on admin media list page
      And I should see "MyMedia"
