require 'json'
require 'rest-client'

module JenkinsStatsd
  class JenkinsClient
    attr_reader :metrics_url

    EXCLUDE = [
      %r(^jenkins\.versions)
    ]

    def initialize(host, api_token)
      @metrics_url = File.join(host, 'metrics', api_token, 'metrics')
    end

    def get_metrics
      metrics = {}
      response = RestClient.get metrics_url
      parsed = JSON.parse(response.body)
      metrics[:gauges] = extract_gauges(parsed)
      metrics
    end

    protected

    def extract_gauges(data)
      gauges = {}
      data['gauges'].each do |key, value|
        EXCLUDE.each do |pattern|
          next if key.match(pattern)

          gauges[key] = value['value']
        end
      end
      gauges
    end
  end
end
