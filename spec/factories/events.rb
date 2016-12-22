FactoryGirl.define do
  factory :future_lunch_at_noon, class: Event do
    title { 'Lunch at noon' }
    description { FFaker::BaconIpsum.paragraph }
    start_date { (Time.zone.now + 10.days).change(hour: 12, min: 0) }
    end_date { (Time.zone.now + 10.days).change(hour: 14, min: 0) }

    factory :event_past, class: Event do
      start_date { (Time.zone.now - 10.days).change(hour: 12, min: 0) }
      end_date { (Time.zone.now - 10.days).change(hour: 14, min: 0) }
      to_create { |instance| instance.save(validate: false) }
    end
  end
end