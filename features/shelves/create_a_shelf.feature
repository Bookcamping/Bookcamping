Feature:
  As a #bookcamping user
  In order to organize my references
  I want to create shelves

  @wip
  Scenario: create an empty shelf
    Given I'm authenticated as "kamen"
    When I go to my profile page
    And follow "new_shelf"
    And fill in "name" with "Para leer"
    And press "submit"
    Then I should be on "Para leer" shelf page
    Then I should see "Librería creada. Puedes añadir libros usando el buscador."
