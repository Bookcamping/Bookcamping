Feature: Render media in blog posts
  In order to include image in the blog posts
  As a #bookcamping admin
  I want to include media bites in blog posts

  Background:
    Given I'm at camp "testcamping"

  @wip
  Scenario:
    Given a media with title "MyStuff"
    Given last media has file "my_file.jpg"
    Given debug media bites
    Given a post with title "MyPost" and "body" is "My stuff is: #{MEDIA:1}"
    When debug posts
    When I go to "MyPost" post page
    Then debug page
    Then I should see "My stuff is: "
    Then I should see "<img"
