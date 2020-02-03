FactoryBot.define do
  factory :event do
    title { "MyEvent" }
    date { Date.today }
    repeatable { 'none' }
  end
end
