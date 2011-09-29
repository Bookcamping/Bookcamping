Feature: List Media
  In order to include some content into the blog
  As a #bookcamping admin
  I want to see the media added

  @current
  Scenario: List media
    Given a "url/image" media with title "My Image" and "url" of "http://go.to/image.jpg"
    When I go to media list page
    Then I should see "My Image"
    And I should see "url/image"
    And I should see "http://go.to/image.jpg"


