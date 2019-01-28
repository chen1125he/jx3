# frozen_string_literal: true

module ApplicationHelper
  def body_class
    format('%<controller>s-%<action>s-page', controller: controller_path.tr('/_', '-'), action: action_name)
  end
end
