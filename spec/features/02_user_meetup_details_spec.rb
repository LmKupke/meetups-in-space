require 'spec_helper'

feature "Hompepage" do
  let!(:user) { User.create(provider: "github", uid: "1", username: "jarlax1", email: "jarlax1@launchacademy.com",avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400") }
  let!(:user2) { User.create(provider: "github", uid: "2", username: "jonsnow", email: "jsnow@got.com",avatar_url: "https://avatars2.got.com/u") }
  let!(:meetup1) { Meetup.create(id: 1,name: "Learning Rails",location: "Boston",description: 'Come join us for a rails sesh',user: user) }
  let!(:meetup2) { Meetup.create(id: 2,name: "All about Boston",location: "New York",description: 'Come join us for learning about Boston in NYC',user: user2) }

  scenario "Meetups listed alphabetically" do
    visit "/meetups"

    expect(page).to have_selector("ul.meetups li:nth-child(1)", text: meetup2.name)
    expect(page).to have_selector("ul.meetups li:nth-child(2)", text: meetup1.name)
  end
  scenario "Should have create meetup link" do
    visit "/meetups"

    expect(page).to have_link("Create a Meetup!")
  end
end
