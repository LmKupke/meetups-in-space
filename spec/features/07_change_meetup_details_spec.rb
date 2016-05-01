feature "Creator change meetup details" do
  let!(:user) { User.create(provider: "github", uid: "1", username: "jarlax1", email: "jarlax1@launchacademy.com",avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400") }
  let!(:meetup1) { Meetup.create(id: 1,name: "Learning Rails",location: "Boston",description: 'Come join us for a rails sesh',user: user) }
  let!(:attendee1) { Usermeetup.create(user: user, meetup: meetup1) }

  scenario "Signed in creator should see link to edit page" do
    visit '/meetups'
    sign_in_as user
    click_link 'Learning Rails'

    expect(page).to have_link("Edit Meetup")
  end

  scenario "Signed in creator should be able see form with values and update link" do
    visit '/meetups'
    sign_in_as user
    click_link 'Learning Rails'
    click_link("Edit Meetup")

    expect(page).to have_css('form.update_meetup')
    expect(page).to have_selector("input#name[value='Learning Rails']")
    expect(page).to have_selector("input#location[value='Boston']")
    expect(page).to have_selector("input#description[value='Come join us for a rails sesh']")

    expect(page).to have_selector("input#update_meetup")
  end
  scenario "Signed in creator should be able to update with form" do
    visit '/meetups'
    sign_in_as user
    click_link 'Learning Rails'
    click_link("Edit Meetup")

    fill_in('location', with: "Titus Sparrow Park Boston,MA")

    click_on "Update Meetup"

    expect(page).to have_content("Learning Rails")
    expect(page).to have_content("Titus Sparrow Park Boston,MA")
    expect(page).to have_content("Come join us for a rails sesh")
    expect(page).to have_content("jarlax1")
  end

end
