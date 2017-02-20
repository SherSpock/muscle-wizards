module ApplicationHelper

  def time_til_contest(object=nil)
    if object
      time = nearest_contest_time - object.created_at
    else
      time = nearest_contest_time - Time.now
    end
    render_time(time)
  end

  def render_time(time)
    if time >= 604800
      weeks = (time / 604800).round(1)
      pluralize(weeks, "week")
    else
      days = (time / 86400).to_i
      pluralize(days, "day")
    end
  end

  def nearest_contest(prep = @prep)
    nearest_active_contest(prep) || last_contest(prep)
  end

  def nearest_active_contest(prep)
    current_time = Time.now
    prep.contests.order(:date).select { |contest| contest.date > current_time }.first
  end

  def last_contest(prep)
    prep.contests.order(:date).last
  end

  def nearest_contest_time
    nearest_contest.date
  end

  def time_out(prep)
    contest = prep.contests.order(:date).first
    time = contest.date - Time.now
    render_time(time) + " out <span class='hide-small'>from " + contest.title + "</span>"
  end

  def prep_thumb(prep)
    prep.photos.any? ? prep.photos.last.image(:thumb) : prep.athlete.avatar(:thumb)
  end

end
