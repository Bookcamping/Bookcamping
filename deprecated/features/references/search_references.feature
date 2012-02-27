Feature: Search references
  In order to find something in chaos
  As a bookcamping user
  I want to search references

  Background:
    Given I'm at camp "testcamping"
    And a book titled "Contra la cultura"
    And last book has "Zemos98" as "authors"
    And last book has "Autoeditoras" as "editor"
    And a book titled "cultura libre"
    And last book has "Zemos98" as "authors"
    And last book has "Autoeditoras plus" as "editor"

  @current
  Scenario: Search by title
    Given I go to "cultura" search results page
    Then I should see "2"
    And I should see "Contra la cultura"
    And I should see "cultura libre"

  @current
  Scenario: Search by author
    Given I go to "Zemos" search results page
    Then I should see "2"
    And I should see "Contra la cultura"
    And I should see "cultura libre"

  @current
  Scenario: Search by editor
    Given I go to "plus" search results page
    Then I should see "1"
    And I should see "cultura libre"
