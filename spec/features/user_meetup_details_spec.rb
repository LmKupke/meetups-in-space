require 'spec_helper'

feature "Hompepage" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end
  let(:meetup) do
    Meetup.create(
      id: 1,
      name: "Learning Rails",
      location: "Boston",
      description: 'Come join us for a rails sesh',
      user: user
    )
  end


  scenario "Meetups listed alphabetically" do
    visit '/'


    expect(page).to have_content ("Title: #{meetup.name}")
    expect(page).to have_content "Location: #{meetup.location}"

  end
end
