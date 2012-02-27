Feature: List posts
  In order to manage the blog
  As a #bookcamping admin
  I want to see the blog posts

  Background:
    Given I'm at camp "TestCamping"
    Given I'm authenticated as "Admin"
    Given I'm an admin

  Scenario: List blog posts
    Given a blog post titled "Post1"
    Given a blog post titled "Post2"
    When I go to admin posts page
    Then I should see "Post1"
    Then I should see "Post2"

