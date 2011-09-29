Feature: List posts
  In order to learn about the project
  As a #bookcamping visitor
  I want to read blog posts

  Background:
    Given a camp named "Camp"

  Scenario: List blog posts
    Given a blog post titled "Post1"
    Given a blog post titled "Post2"
    When I go to posts page
    Then I should see "Post1"
    Then I should see "Post2"

  @current
  Scenario: List public blog posts
    Given a blog post titled "Post1"
    And last post is "public"
    And a blog post titled "Post2"
    And last post is "private"
    When I go to posts page
    Then I should see "Post1"
    Then I should not see "Post2"