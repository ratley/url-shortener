class Url < ActiveRecord::Base
  before_create :create_short_url
  before_create :add_http
  validate :has_domain
  # validate :begins_with_http

  def create_short_url
    self.short_url = SecureRandom.hex(3)
  end

  def add_http
    long_url = self.long_url
    unless long_url.include?('http://') || self.long_url.include?('https://')
       long_url.insert(0, "http://")
    end
  end

  def begins_with_http_or_https
    unless /[\Ahttps:\/\/]{7,8}/.match(self.long_url)
      errors.add(:long_url, "needs to begin with http")
    end
  end

  def self.domain_parser
    domain_arr = Array.new
    domain_site = Nokogiri::HTML(open("http://www.computerhope.com/jargon/num/domains.htm"))
    domain_site.css('td > b').each do |domain|
      domain_arr << domain.text
    end
    domain_arr
  end

  def has_domain
    unless Url.domain_parser.any? { |e| self.long_url.include? e }
      errors.add(:long_url, "must have an internet domain suffix")
    end
  end

end
