require 'cabin'
require 'elasticsearch'

class Cabin::Outputs::ElasticSearch
  attr_accessor :index, :type, :urls

  def initialize(es_urls, index, type="cabin", logger=nil)
    es_urls = [es_urls] if es_urls.is_a? String
    self.urls = es_urls
    self.index = index
    self.type = type
    raise Exception.new 'Index must be not blank for Cabin::Outputs::ElasticSearch' if index.nil? or index =~ /^\s*$/
    raise Exception.new 'Type must be not blank for Cabin::Outputs::ElasticSearch' if type.nil? or type =~ /^\s*$/
    raise Exception.new 'At least one URL must be provided to Cabin::Outputs::ElasticSearch' if es_urls.nil? or es_urls.count == 0
    @es = Elasticsearch::Client.new urls: es_urls, logger: logger
  end

  def <<(event)
    type = event.delete :_type
    type = self.type if type.nil?
    @es.index index: self.index, type: type, body: event
  end
end
