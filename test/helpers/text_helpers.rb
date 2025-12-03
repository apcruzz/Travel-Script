module TextHelpers
  def assert_text(text)
    assert page.has_content?(text), "Expected to find #{text} in #{page.text}, but did not."
  end

  def refute_text(text)
    assert_not page.has_content?(text), "Expected to find #{text} in #{page.text}, but did not."
  end
end
