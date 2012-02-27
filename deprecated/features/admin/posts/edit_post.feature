Feature: Edit post
  In order to correct our word
  As a #bookcamping admin
  I want to edit posts

  Background:
    Given a camp named "bookcamping"
    And I'm authenticated as "Dani"
    And I'm an admin

  Scenario: I should be able to edit post
    Given a blog post titled "Entrada"
    When I go to admin posts page
    Then I should see "Editar"
    When I follow "Editar"
    Then I should be on edit "Entrada" admin post page

  Scenario: Edit a post
    Given a blog post titled "Uno"
    When I go to edit "Uno" admin post page
    And I fill in "post[author]" with "Pirsig"
    And I press "submit_post"
    Then I should see "Pirsig"

