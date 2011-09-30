Feature: List Media
  In order to include some content into the blog
  As a #bookcamping admin
  I want to see the media added

  Background:
    Given I'm at camp "testcamping"
    And I'm authenticated as "admin"
    And I'm an admin

  Scenario: List media
    Given a "url/image" media with title "My Image" and "link" of "http://link.to"
    When I go to admin media list page
    Then I should see "My Image"
    And I should see "http://link.to"


