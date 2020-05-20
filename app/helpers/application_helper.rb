module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "alert-info" #lightblue
      when :success then "alert-success" #green
      when :error then "alert-warning" #yellow
      when :alert then "alert-error" #red
    end
  end
end
