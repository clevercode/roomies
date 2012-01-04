if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all

  # ignore these massive objects that don't really help.
  Footnotes::Notes::AssignsNote.ignored_assigns += [:@_env, :@_view_renderer]
end
