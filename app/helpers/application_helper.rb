module ApplicationHelper
  # добавить поле при регистрации чтоб указать урл аватарки
  # если оно пустое то устанавить его в рандом
  # и в настройках тоде самое с апдейт
  # todo
  def user_avatar(user)
    user.avatar_url ||= (asset_path "avatar#{rand(1..5)}.jpg")
  end

  def decline(number, krokodil, krokodila, krokodilov, with_number = false)
    number = 0 if number == nil || !number.is_a?(Numeric)

    prefix = ''
    prefix = "#{number}" if with_number

    devision_amount = number % 10
    devision_amount100 = number % 100
    return "#{prefix} #{krokodilov}" if devision_amount100.between?(11,14)
    return "#{prefix} #{krokodil}" if devision_amount == 1
    return "#{prefix} #{krokodila}" if devision_amount.between?(2,4)
    return "#{prefix} #{krokodilov}" if devision_amount.between?(5,9) || devision_amount.zero?
  end

  def current_user
    current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # todo
  # сделать хелпер который перед удалением акк запрашивает
  # решить примерчик и ввести результат в поле
end
