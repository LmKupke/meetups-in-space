feature "Create a new meetup" do
  let(:user) { User.create(provider: "github", uid: "1", username: "jarlax1", email: "jarlax1@launchacademy.com",avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400") }

  scenario "See form page" do
    visit '/meetups/new'
    expect(page).to have_css('form.create_meetup')
  end

  scenario "Signed in User submits" do
    sign_in_as user
    visit '/meetups/new'
    fill_in('name', with: "Croquet")
    fill_in('location', with: "Titus Sparrow Park Boston,MA")
    fill_in('description', with: "Having a bunch of people over for croquet!")
    click_on "Create Meetup"

    expect(page).to have_content("Croquet")
    expect(page).to have_content("Titus Sparrow Park Boston,MA")
    expect(page).to have_content("Having a bunch of people over for croquet!")
    expect(page).to have_content("jarlax1")

  end

  scenario "Non-signed in User submits" do

    visit '/meetups/new'
    fill_in('name', with: "Croquet")
    fill_in('location', with: "Titus Sparrow Park Boston,MA")
    fill_in('description', with: "Having a bunch of people over for croquet!")
    click_on "Create Meetup"


    expect(page).to have_content("You will need to sign in before you can create a Meetup!")

  end
end
