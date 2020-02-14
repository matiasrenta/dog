class Notificator
  def self.send(sender, recipients, body, icon = 'fa-cube')
      sender.send_message(recipients, body, default_subject_custom_icon(icon))
  end

  def self.make_body_for_crud_actions(user, action, entity, view_context)
    url = eval "view_context.#{entity.class.name.underscore}_path(entity)"
    "#{user.name} #{action} #{I18n.t("activerecord.models.#{entity.class.name.underscore}.one")} #{view_context.link_to(entity.name, url, class: 'display-normal')}"
  end

  #def self.default_subject
  #  '<em class="badge padding-5 no-border-radius bg-color-blue pull-left margin-right-5"><i class="fa fa-cube fa-fw fa-1x"></i></em>'
  #end

  def self.default_subject_custom_icon(icon)
    "<em class=\"badge padding-5 no-border-radius bg-color-blue pull-left margin-right-5\"><i class=\"fa #{icon} fa-fw fa-1x\"></i></em>"
  end

  def self.recipients_from_body(body)
    user_ids = []
    body.split('](').each_with_index do |string, index|
      user_ids << string.partition(')').first if index > 0
    end
    User.where(id: user_ids)
  end

  def self.notify_afectacion_to_revisores(key_analytical, sender)
      recipients = User.actives.revisores
      if recipients.size > 0
        entity_link = view_context.link_to(key_analytical.short_key_analytical_string, key_analytical_path(key_analytical), class: 'display-normal')
        Notificator.send(current_user, recipients, "<strong>#{sender.name_or_email}</strong> realizó una <strong>#{key_analytical.status}</strong> en el proyecto #{entity_link}")
      end
  end

end