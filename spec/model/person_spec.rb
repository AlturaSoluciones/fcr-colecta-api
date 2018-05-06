require 'rails_helper'

RSpec.describe Person, type: :model do
  before do
    @person = FactoryBot.build(:person)
  end

  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }

  it "has a valid email" do
    expect(@person.valid?).to eq true
  end

  it "has NOT a valid email" do
    @person.email = 'test@gmail'
    expect(@person.valid?).to eq false
  end

  it "Correct idenfifier" do
    @person.identifier = '1'
    expect(@person.valid?).to eq false
    @person.identifier = '0400012530'
    expect(@person.valid?).to eq true
    @person.identifier = '1710034065'
    expect(@person.valid?).to eq true
    @person.identifier = '0400987540'
    expect(@person.valid?).to eq false
    @person.identifier = '0400987541'
    expect(@person.valid?).to eq true
  end
end
