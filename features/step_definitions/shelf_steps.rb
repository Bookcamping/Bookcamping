Given /^a shelf$/ do
  Given "a camp"
  @shelf ||= FactoryGirl.create(:shelf, camp: @camp)
end
