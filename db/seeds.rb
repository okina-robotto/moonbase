Amazon::TransactionType.create([{ name: "Order" },
                                { name: "Refund" },
                                { name: "Service Fee" },
                                { name: "Adjustment" },
                                { name: "Transfer" },
                                { name: "FBA Inventory Fee" }])

Amazon::Fulfillment.create([{ name: "Amazon" }])

Amazon::TaxCollectionModel.create([{ name: "MarketplaceFacilitator" }])

::Currency::ExchangeRates::SyncService.new.call

Amazon::Marketplace.create([{ name: "amazon.com", currency_exchange_rate: Currency::ExchangeRate.where(code: "USD")&.first },
                            { name: "amazon.ca", currency_exchange_rate: Currency::ExchangeRate.where(code: "CAD")&.first },
                            { name: "amazon.mx", currency_exchange_rate: Currency::ExchangeRate.where(code: "MXN")&.first },
                            { name: "amazon.br", currency_exchange_rate: Currency::ExchangeRate.where(code: "BRL")&.first },
                            { name: "amazon.ae", currency_exchange_rate: Currency::ExchangeRate.where(code: "AED")&.first },
                            { name: "amazon.de", currency_exchange_rate: Currency::ExchangeRate.where(code: "EUR")&.first },
                            { name: "amazon.es", currency_exchange_rate: Currency::ExchangeRate.where(code: "EUR")&.first },
                            { name: "amazon.fr", currency_exchange_rate: Currency::ExchangeRate.where(code: "EUR")&.first },
                            { name: "amazon.co.uk", currency_exchange_rate: Currency::ExchangeRate.where(code: "GBP")&.first },
                            { name: "amazon.in", currency_exchange_rate: Currency::ExchangeRate.where(code: "INR")&.first },
                            { name: "amazon.it", currency_exchange_rate: Currency::ExchangeRate.where(code: "EUR")&.first },
                            { name: "amazon.nl", currency_exchange_rate: Currency::ExchangeRate.where(code: "EUR")&.first },
                            { name: "amazon.sa", currency_exchange_rate: Currency::ExchangeRate.where(code: "SAR")&.first },
                            { name: "amazon.com.tr", currency_exchange_rate: Currency::ExchangeRate.where(code: "TRY")&.first },
                            { name: "amazon.sg", currency_exchange_rate: Currency::ExchangeRate.where(code: "SGD")&.first },
                            { name: "amazon.com.au", currency_exchange_rate: Currency::ExchangeRate.where(code: "AUD")&.first },
                            { name: "amazon.co.jp", currency_exchange_rate: Currency::ExchangeRate.where(code: "JPY")&.first }])
