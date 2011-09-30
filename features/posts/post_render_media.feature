Feature: Render media in blog posts
  In order to include image in the blog posts
  As a #bookcamping admin
  I want to include media bites in blog posts

  Background:
    Given I'm at camp "testcamping"

  @current
  Scenario:
    Given a media with title "MyStuff" and "file_content" is "my_image.jpg"
    Given a post with title "MyPost" and "body" is "#{MEDIA:1}"
    When debug posts
    When I go to "MyPost" post page
    Then I should see "<img"
