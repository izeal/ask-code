module ApplicationHelper
  def decline(number, krokodil, krokodila, krokodilov, with_number = false)
    number = 0 if number == nil || !number.is_a?(Numeric)

    prefix = ''
    prefix = "#{number}" if with_number

    return "#{prefix} #{krokodilov}" if number.zero?

    devision_amount = number % 10
    devision_amount100 = number % 100
    return "#{prefix} #{krokodilov}" if devision_amount100.between?(11,14)
    return "#{prefix} #{krokodil}" if devision_amount == 1
    return "#{prefix} #{krokodila}" if devision_amount.between?(2,4)
    return "#{prefix} #{krokodilov}" if devision_amount.between?(5,9) || devision_amount.zero?
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def author_id_finder
    current_user.id
  end

  def author_of?(post)
    return if post.nil?
    post.author == current_user
  end

  def owner_of?(model)
    return if model.nil?
    model.user == current_user
  end

  def is_this_the_last?(comment)
    comment.post.comments.last == comment
  end
end
