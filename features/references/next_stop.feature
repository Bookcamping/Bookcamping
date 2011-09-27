Feature: Next stop
  As a #bookcamping user
  In order to find interesting books
  I want to mark or see how they are related

  @wip
  Scenario: Relate two books
    Given a booka titled 'First'
    Given a booka titled 'Second'
    When I go to First's book page
    And I follow 'new-next-stop'

