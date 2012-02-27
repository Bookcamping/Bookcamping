Feature: View latests public posts

  Background:
    Given I'm at camp "testcamping"

  Scenario: List public blog posts
    Given a blog post titled "Post1"
    And last post is "public"
    And a blog post titled "Post2"
    And last post is "private"
    When I go to posts page
    Then I should see "Post1" within "#latest-posts"
    Then I should not see "Post2" within "#latest-posts"