Feature: Create media bite

  Background:
    Given I'm at camp "testcamping"
    And I'm authenticated as "admin"
    And I'm an admin

    Scenario: Create media bite
      When I go to new admin media page
      And I fill in "media_bite[title]" with "MyMedia"
      And I fill in "media_bite[link]" with "http://link.to"
      And press "submit_media_bite"
      Then I should be on "MyMedia" admin media page
      And I should see "MyMedia"
      And I should see "http://link.to"
