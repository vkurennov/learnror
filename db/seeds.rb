[
    {title: 'Категории', action: :manage, subject: 'Category'},
    {title: 'Продукты', action: :manage, subject: 'Product'},
    {title: 'Пользователи', action: :manage, subject: 'User'},
    {title: 'Права', action: :manage, subject: 'Permission'}
].each do |permission|
  title = permission.delete(:title)
  p = Permission.where(permission).first
  p.present? ? p.update(title: title) : Permission.create!(permission.merge(title: title))
end

