# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def bootstrap_flash_class(type)
    case type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def bootstrap_order_table_class(type)
    case type
    when 'new'
      'table-primary'
    when 'failed'
      'table-danger'
    else
      ''
    end
  end

  def bootstrap_status_pill_class(type)
    case type
    when 'new', 'pending'
      'badge-primary'
    when 'failed', 'canceled'
      'badge-danger'
    when 'completed', 'shipped'
      'badge-success'
    when 'ready'
      'badge-info'
    else
      'badge-secondary'
    end
  end

  def resource_name(resource)
    resource.class.to_s.downcase
  end
end
