Feature: Create post
  In order to spread the word
  As a #bookcamping admin
  I want to create a new post

  Background:
    Given a camp named "bookcamping"
    And I'm authenticated as "Dani"
    And I'm and admin

  Scenario: I'm able to create a new post
    When I go to posts page
    Then I should see "Crear entrada"
    And I follow "Crear entrada"
    Then I should be on new post page

  Scenario: Create a new post
    When I go to new post page
    And I fill in "post[title]" with "Primer Post"
    And I fill in "post[author]" with "Bartebly"
    And I select "Público" from "post[visibility]"
    And I fill in "post[body]" with "Mi primer text."
    # TODO: ver por qué no funciona "Guardar entrada"
    And I press "submit_post"
    Then I should be on "Primer Post" post page
    And I should see "Primer Post"
    And I should see "Bartebly"
    And I should see "Mi primer text."
