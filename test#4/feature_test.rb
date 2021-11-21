require 'nokogiri'
require 'open-uri'
require 'rspec/autorun'

class Browser 
  def initialize(params = {})
    @url = params[:url] ||= 'https://fr.wikipedia.org/wiki/Ruby'
    scrape
  end

  def scrape 
    @unparsed_page = URI.open(@url).read
    @parsed_page = Nokogiri::HTML(@unparsed_page)
  end

  def has_title?
    !!@parsed_page.search('h1')
  end

  def title
    @parsed_page.search('h1').text
  end

  def has_logo?
    !!@parsed_page.search('.mw-logo')
  end
end


describe 'Wikipedia Feature Specs' do
  let(:browser) { Browser.new }

  describe Browser do
    describe '#has_title?' do
      it 'should return true if the webpage has an h1 title' do
        expect(browser.has_title?).to eq(true)
      end

      it 'should return the text of the title' do
        expect(browser.title).to eq('Ruby')
      end

      it 'should return if the wikipedia logo is displayed' do
        expect(browser.has_logo?).to eq(true)
      end
    end
  end
end