require 'rspec/autorun'
require_relative './kit.rb'

describe 'Kit' do
  let(:kit) { Kit.new }

  describe '#type' do
    it 'should return the correct type' do
      expect(kit.type).to eq('kit')
    end
  end

  describe '#id' do
    it 'should return the id of the kit' do
      expect(kit.id).to eq(1)
    end
  end

  describe '#owners' do
    it 'should return the correct number of owners' do
      expect(kit.owners.size).to eq(4)
    end
  end

  describe '#draggable' do
    it 'should return if the kit is draggable or not' do
      expect(kit.draggable?).to eq(true)
    end
  end
end