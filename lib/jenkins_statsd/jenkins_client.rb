require 'json'
require 'rest-client'

module JenkinsStatsd
  class JenkinsClient
    attr_reader :metrics_url

    GAUGES_EXCLUDE = [
      %r(^jenkins\.versions)
    ]

    METERS_EXCLUDE = [
      %r(^http)
    ]

    def initialize(host, api_token)
      @metrics_url = File.join(host, 'metrics', api_token, 'metrics')
    end

    def get_metrics
      metrics = {}
      response = RestClient.get metrics_url
      parsed = JSON.parse(response.body)
      metrics[:gauges] = extract_gauges(parsed)
      metrics[:meters] = extract_meters(parsed)
      metrics
    end

    protected

    def ignore?(str, list)
      list.each do |pattern|
        return true if str.match(pattern)
      end
      false
    end

    def extract_gauges(data)
      gauges = {}
      data['gauges'].each do |key, value|
        next if ignore?(key, GAUGES_EXCLUDE)

        gauges[key] = value['value']
      end
      gauges
    end

    def extract_meters(data)
      meters = {}
      data['meters'].each do |key, value|
        next if ignore?(key, METERS_EXCLUDE)
        meters["#{key}.m1_rate"] = value['m1_rate']
      end
      meters
    end
  end
end
