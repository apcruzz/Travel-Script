class Current < ActiveSupport::CurrentAttributes
  attribute :session, :user

  # Optional: keep these in sync automatically
  def session=(session)
    super
    self.user = session&.user
  end
end
