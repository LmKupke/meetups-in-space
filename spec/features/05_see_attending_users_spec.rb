feature "See attending users" do
  let!(:user) { User.create(provider: "github", uid: "1", username: "jarlax1", email: "jarlax1@launchacademy.com",avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400") }
  let!(:meetup1) { Meetup.create(id: 1,name: "Learning Rails",location: "Boston",description: 'Come join us for a rails sesh',user: user) }
  let!(:user2) { User.create(provider: "github", uid: "2", username: "jonsnow", email: "jonsnow@launchacademy.com",avatar_url: "http://avatarfiles.alphacoders.com/136/13622.jpg") }
  let!(:attendee1) { Usermeetup.create(user: user, meetup: meetup1) }
  let!(:attendee2) { Usermeetup.create(user: user2, meetup: meetup1) }
  scenario "Meetup is linked and shows details" do

    visit "/meetups"
    click_link "Learning Rails"

    expect(page).to have_content(meetup1.name)
    expect(page).to have_content(meetup1.description)
    expect(page).to have_content(meetup1.location)
    expect(page).to have_content(meetup1.user.username)

    expect(page).to have_content(attendee1.user.username)
     
  end
end
