feature "Join a Meetup" do
  let!(:user) { User.create(provider: "github", uid: "1", username: "jarlax1", email: "jarlax1@launchacademy.com",avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400") }
  let!(:meetup1) { Meetup.create(id: 1,name: "Learning Rails",location: "Boston",description: 'Come join us for a rails sesh',user: user) }
  let!(:user2) { User.create(provider: "github", uid: "2", username: "jonsnow", email: "jonsnow@launchacademy.com",avatar_url: "http://avatarfiles.alphacoders.com/136/13622.jpg") }
  let!(:attendee1) { Usermeetup.create(user: user, meetup: meetup1) }

  scenario "A random signed-in user attendees meetup" do
    visit "/meetups"
    sign_in_as user2
    click_link "Learning Rails"
    click_button "Join"
    
    Usermeetup.create(user: user2, meetup: meetup1)

    expect(page).to have_content("You have joined the meetup.")
    expect(page).to have_content(user2.username)
  end
  scenario "Not signed in user attempt to join" do
    visit "/meetups"
    click_link "Learning Rails"

    expect(page).to have_selector("input[type=submit][value='Join']")
    click_button "Join"
    expect(page).to have_content("Please sign in before joining meetups")
  end

  scenario 'visits show page signed in and already member of event' do
    visit "meetups"
    sign_in_as user
    click_link "Learning Rails"

    expect(page).to have_no_selector("input[type=submit][value='Join']")
  end
end
