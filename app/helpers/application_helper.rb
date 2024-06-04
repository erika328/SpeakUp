module ApplicationHelper
  def flash_background_color(key)
    case key.to_sym
    when :notice then "animate-fade-out-top text-sm text-green-800 border border-green-300 rounded-lg bg-green-50"
    when :success then "animate-fade-out-top text-sm text-green-800 border border-green-300 rounded-lg bg-green-50"
    when :alert  then "flex items-center p-4 mb-4 text-sm text-red-800 border border-red-300 rounded-lg bg-red-50"
    else "animate-fade-out-top flex items-center p-4 mb-4 text-sm text-yellow-800 border border-yellow-300 rounded-lg bg-yellow-50"
    end
  end

  def turbo_stream_flash
  turbo_stream.update "flash", partial: "shared/flash_messages"
  end

  def clean_word(word)
    word.gsub(/[!.,?]/, '')
  end
end
