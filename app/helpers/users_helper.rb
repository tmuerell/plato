module UsersHelper
  def gravatar_icon(user, additional_classes = [])
    image_tag user.gravatar_url(secure: true, rating: 'R', size: 26, default: 'identicon'), class: ['clipped-circle'] + additional_classes
  end
end