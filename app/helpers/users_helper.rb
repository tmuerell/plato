module UsersHelper
  def gravatar_icon(user, additional_classes = [], size = 26)
    image_tag user.gravatar_url(secure: true, rating: 'R', size: size, default: 'identicon'), class: ['clipped-circle'] + additional_classes, alt: user.name, title: user.name
  end
end
