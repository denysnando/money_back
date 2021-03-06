# frozen_string_literal: true

module WelcomesHelper
  def welcome_title_label
    if current_user.admin?
      tag.span('Acesso do Administrador', class: 'label label-danger')
    else
      tag.span('Acesso do Cliente', class: 'label label-info')
    end
  end
end
