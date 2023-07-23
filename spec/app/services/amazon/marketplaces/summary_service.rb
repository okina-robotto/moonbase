describe Amazon::Marketplaces::SummaryService do
  context :call do
    Given { create(:amazon_marketplace) }

    When(:marketplaces) do
      Amazon::Marketplaces::SummaryService.call
    end

    Then { expect(marketplaces).to be_truthy }
    And { expect(marketplaces.count).to eq(1) }
  end
end
