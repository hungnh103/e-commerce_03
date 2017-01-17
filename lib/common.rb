module SharedMethods
  def get_current_monday
    current_date = Time.now
    until current_date.monday? do
      current_date = current_date - Settings.one.day
    end
    current_date
  end
end
