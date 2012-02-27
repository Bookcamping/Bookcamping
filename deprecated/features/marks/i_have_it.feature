Feature:
  As a library shop in #bookcamping
  I want the people know where to buy some book

  Background:
    # Given a book titled "Teoría King Kong"
    # And a shop called "La Fuga"


  @wip
  Scenario: No one have it
    When I visit "Teoría King Kong" book page
    Then I should see "0 librerías lo tienen."

  @wip
  Scenario: Mark a reference as 'I have it'
    Given I'am authenticated as "Luis"
    And I belongs to the shop "La Fuga"
    When I visit "Teoría King Kong" book page
    And I follow "mark-i-have-it"
    Then I should see "1 librería lo tiene"
