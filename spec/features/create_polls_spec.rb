require 'rails_helper'

RSpec.feature "CreatePolls", type: :feature, js: true do

  it "can create a test" do
    visit root_path
    expect(page).to have_content("Poll★Star")
    fill_in "Poll Title", with: "Where are you?"
    fill_in "poll_options-1", with: "Home"
    click_on "Add Option"
    fill_in "poll_options-2", with: "Vacation"
    click_on "Add Option"
    fill_in "poll_options-3", with: "Work"
    click_on "Create"
    expect(page).to have_content("Share the URL")
  end
end
