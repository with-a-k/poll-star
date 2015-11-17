require 'rails_helper'

RSpec.feature "VoteOnPolls", type: :feature, js: true do
  before(:each) do
    visit root_path
    fill_in "Poll Title", with: "Your Favorite Undertale"
    fill_in "poll_options-1", with: "Sans"
    click_on "Add Option"
    fill_in "poll_options-2", with: "Papyrus"
    click_on "Add Option"
    fill_in "poll_options-3", with: "Undyne"
    click_on "Add Option"
    fill_in "poll_options-4", with: "Alphys"
    click_on "Add Option"
    fill_in "poll_options-5", with: "Mettaton"
    click_on "Add Option"
    fill_in "poll_options-6", with: "Toriel"
    click_on "Add Option"
    fill_in "poll_options-7", with: "Asgore"
    click_on "Create"
  end

  it "can vote on a poll" do
    poll = Poll.find_by(title: "Your Favorite Undertale")
    visit poll_vote_path(:public_obfuscator => poll.public_obfuscator)
    click_on "Toriel"
    expect(page).to have_content("Toriel: 1")
  end
end
