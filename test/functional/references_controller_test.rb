require 'test_helper'

describe "References controller integration" do
  it "should search across campings" do
    c1 = create(:camp)
    c2 = create(:camp)
    r1 = create(:reference, authors: 'Orozco', camp: c1)
    r2 = create(:reference, authors: 'Orozco', camp: c2)
    visit search_path('orozco')
    page.text.must_include r1.title
    page.text.must_include r2.title
  end
end
