module MessagesHelper

  def new_message_count_print
    new_message_count > 0 ? "(#{new_message_count})" : "" if new_message_count
  end

end
