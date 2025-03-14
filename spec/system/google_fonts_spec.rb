# frozen_string_literal: true

RSpec.describe "Google Fonts", type: :system do
  let!(:theme) { upload_theme_component }

  before do
    theme.update_setting(:fonts, "Roboto|Open Sans")
    theme.update_setting(:body_font, "Roboto")
    theme.update_setting(:headline_font, "Open Sans")
    theme.save!
  end

  it "loads the correct stylesheets" do
    visit("/")

    # Have to check page HTML because these aren't visible elements
    expect(page.html).to include('href="https://fonts.googleapis.com')
    expect(page.html).to include("family=Roboto:")
    expect(page.html).to include("family=Open+Sans:")
  end

  it "formats URLs correctly" do
    theme.update_setting(:fonts, "Open Sans|Roboto Slab")
    theme.update_setting(:body_font, "Open Sans")
    theme.update_setting(:headline_font, "Roboto Slab")
    theme.save!

    visit("/")

    expect(page.html).to include("family=Open+Sans:")
    expect(page.html).to include("family=Roboto+Slab:")
  end

  it "does not load when setting is empty" do
    visit("/")
    expect(page.html).to include('href="https://fonts.googleapis.com')

    theme.update_setting(:fonts, "")
    theme.save!

    visit("/")
    expect(page.html).not_to include("family=Roboto:")
    expect(page.html).not_to include("family=Open+Sans:")
  end
end
