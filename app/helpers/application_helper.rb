# frozen_string_literal: true

module ApplicationHelper
  def body_class
    format('%<controller>s-%<action>s-page', controller: controller_path.tr('/_', '-'), action: action_name)
  end

  def active_menu_class(controller_names = [], action_names = [])
    return '' unless controller_names.present?

    controller_names.map!(&:to_s)
    action_names.map!(&:to_s)

    return 'open active' if controller_names.include?(controller_name) && action_names.blank?
    return 'open active' if controller_names.include?(controller_name) && action_names.include?(action_name)

    ''
  end

  def flash_class(level)
    case level
    when 'notice', 'success' then 'alert alert-success alert-dismissible'
    when 'info' then 'alert alert-info alert-dismissible'
    when 'warning' then 'alert alert-warning alert-dismissible'
    when 'alert', 'error' then 'alert alert-danger alert-dismissible'
    end
  end
end
