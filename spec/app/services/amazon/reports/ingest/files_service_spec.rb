describe Amazon::Reports::Ingest::FilesService do
  context :call do
    Given(:user_id) { "408a3dca-69d4-4bf1-b859-e4a67f50a091" }
    Given(:key) { "unprocessed" }
    Given(:files_service) do
      ::Amazon::Reports::Ingest::FilesService.new(user_id:, key:)
    end

    When(:result) do
      VCR.use_cassette("app/services/amazon/reports/ingest/files_service", match_requests_on: %i[body method]) do
        files_service.call
      end
    end

    Then { expect(result.success?).to be_truthy }
  end
end
