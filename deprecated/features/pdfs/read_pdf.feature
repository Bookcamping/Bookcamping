Feature:
  As a #bookcamping visitor
  I want to read books with free licenses

  @wip
  Scenario: Read a book
    Given a pdf of "Teoría King Kong"
    When I go "Toería King Kong" reference page
    Then I should see "Leer"