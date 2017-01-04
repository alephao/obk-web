require 'rails_helper'

describe Volunteer, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:mobile_number) }
  it { is_expected.to validate_presence_of(:dob) }
  it { is_expected.to validate_inclusion_of(:gender).in_array(%w(M F O)) }

  context 'Date of birth is nil' do
    before { subject.dob = nil }
    it { is_expected.not_to validate_presence_of(:wwccn) }
  end

  context 'Date of birth lesser than eighteen' do
    before { subject.dob = 16.years.ago }
    it { is_expected.not_to validate_presence_of(:wwccn) }
  end

  context 'Date of birth greater than eighteen' do
    before { subject.dob = 19.years.ago }
    it { is_expected.to validate_presence_of(:wwccn) }
  end

  context 'With invalid email' do
    it { is_expected.not_to allow_value('invalidemail').for(:email) }
  end

  context 'With valid email' do
    it { is_expected.to allow_value(FFaker::Internet.email).for(:email) }
  end
end