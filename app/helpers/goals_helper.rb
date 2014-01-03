module GoalsHelper
  def hint_links(hints)
    links = hints.map do |hint|
      link_to hint, root_path(hint: hint.parameterize)
    end

    links.join(" &middot; ")
  end
end
