module BuildsHelper
  def gitlab_build_compare_link build, project
    gitlab_url = project.gitlab_url

    prev_build = project.builds.where("id < #{build.id}").where(ref: build.ref).order('id desc').first

    compare_link = prev_build && prev_build.sha != build.sha

    if compare_link
      gitlab_url << "/compare/#{prev_build.short_sha}...#{build.short_sha}"
      link_to "Compare #{prev_build.short_sha}...#{build.short_sha}", gitlab_url
    else
      gitlab_url << "/commit/#{build.short_sha}"
      link_to "#{build.short_sha}", gitlab_url
    end
  end

  def build_duration build
    distance_of_time_in_words(build.started_at, build.finished_at || Time.now)
  end
end