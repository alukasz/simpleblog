FactoryGirl.define do
  factory :post do
    title 'Post title'
    teaser 'Post teaser'
    text 'Post text'

    factory :invalid_post do
      title ''
    end
  end
end
