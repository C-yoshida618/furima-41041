FactoryBot.define do
  factory :user do
    nickname { 'きいろ' }
    email { Faker::Internet.email }
    password { 'test1234' }
    password_confirmation { password }
    last_name { '山田' }
    first_name { '陸太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'リクタロウ' }
    birthday { '2000-01-01' }
  end
end
