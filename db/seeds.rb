MIN_BULLETINS_COUNT = 150
MIN_USERS_COUNT = 1

[
  'Недвижимость',
  'Транспорт',
  'Товары для хобби и отдыха',
  'Личные вещи',
  'Товары для дома и дачи',
  'Услуги',
  'Электроника',
  'Животные и товары для них',
  'Другое'
].each do |name|
  Category.find_or_create_by!(name:)
end

if User.count < MIN_USERS_COUNT
  (MIN_USERS_COUNT - User.count).times do |i|
    user = User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email
    )
  end
end

if Bulletin.count < MIN_BULLETINS_COUNT
  files = Dir[Rails.root.join('test/fixtures/files/*')]

  (MIN_BULLETINS_COUNT - Bulletin.count).times do |i|
    bulletin = Bulletin.new(
      title: Faker::Food.dish,
      description: Faker::Food.description,
      user_id: User.all.sample.id,
      category_id: Category.all.sample.id
    )

    file = File.open(files.sample)
    bulletin.image.attach(io: file, filename: File.basename(file), content_type: 'image/jpg')
    bulletin.save!
    file.close
    bulletin.to_moderate!
    bulletin.publish!
  end
end
