Feature: List posts
  In order to learn about the project
  As a #bookcamping visitor
  I want to read blog posts

  Scenario: List blog posts
    Given a camp named "Camp"
    Given a blog post titled "Post1"
    Given a blog post titled "Post2"
    When I go to posts page
    Then I should see "Post1"
    Then I should see "Post2"
