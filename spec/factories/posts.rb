FactoryGirl.define do
  factory :post do
    title 'MyString'
    teaser 'MyString'
    text 'MyText'

    factory :invalid_post do
      title ''
    end
  end
end
