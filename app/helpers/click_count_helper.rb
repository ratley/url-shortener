helpers do
  def click_count_plus_one(url)
    @url_created.click_count += 1
    @url_created.save
  end

  def click_count_minus_one(url)
    @url_created.click_count -= 1
    @url_created.save
  end
end
