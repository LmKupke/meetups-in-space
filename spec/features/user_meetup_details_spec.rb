require 'spec_helper'

feature "Hompepage" do
  scenario "Meetups listed alphabetically" do

  user = User.create(provider: "github", uid: "1", username: "jarlax1", email: "jarlax1@launchacademy.com",avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400")
  user2 = User.create(provider: "github", uid: "2", username: "jonsnow", email: "jsnow@got.com",avatar_url: "https://avatars2.got.com/u")
  meetup1 = Meetup.create(id: 1,name: "Learning Rails",location: "Boston",description: 'Come join us for a rails sesh',user: user)
  meetup2 = Meetup.create(id: 2,name: "All about Boston",location: "New York",description: 'Come join us for learning about Boston in NYC',user: user2)

  visit "/meetups"


  expect(page).to have_selector("ul.meetups li:nth-child(1)", text: meetup2.name)
  expect(page).to have_selector("ul.meetups li:nth-child(2)", text: meetup1.name)

  end
end
