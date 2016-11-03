require 'cabin'
require 'elasticsearch'

class Cabin::Outputs::ElasticSearch
  attr_accessor :settings, :es

  def initialize(args={})
    logger = args.delete 'logger'
    self.settings = {index: 'cabin', type: 'cabin'}.merge(args)
    sanity_check!
    self.es = Elasticsearch::Client.new urls: settings[:urls], logger: logger
  end

  def sanity_check!
    settings[:urls] ||= [settings.delete(:url)] if settings.key? :url
    [:index, :type].each {|x| settings[x] = settings[x].to_s}
    raise Exception.new 'Index must be not blank for Cabin::Outputs::ElasticSearch' if settings[:index] =~ /^\s*$/
    raise Exception.new 'Type must be not blank for Cabin::Outputs::ElasticSearch' if settings[:type] =~ /^\s*$/
    raise Exception.new 'At least one URL must be provided to Cabin::Outputs::ElasticSearch' if settings[:urls].nil? or settings[:urls].count == 0
  end

  def <<(event)
    type = event.delete :_type
    type = event.delete "_type" if type.nil?
    type = settings[:type] if type.nil?
    es.index index: settings[:index], type: type.to_s, body: event
  end
end
