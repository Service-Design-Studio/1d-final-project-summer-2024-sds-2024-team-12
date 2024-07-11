When("I see suggestion to change limit in the carousel") do
  within('.carousel-inner') do
    carousel_items = all('.item')

    suggestions_item = carousel_items.find do |item|
      item.has_css?('.carousel-caption p.textheader', text: 'Suggestion:')
    end

    if suggestions_item
      # Perform your assertions or actions here
      within(suggestions_item) do
        expect(page).to have_css('.carousel-caption p.textheader', text: 'Suggestion:')
        expect(page).to have_content('Your card usage is nearing')
      end
    else
      raise "No carousel item with suggestion found"
    end
  end
end
