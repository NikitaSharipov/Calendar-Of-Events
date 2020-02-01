FactoryBot.define do
  factory :event do
    title { "MyEvent" }
    date { Date.today }
  end
end
