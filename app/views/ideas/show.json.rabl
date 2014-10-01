object @idea

attributes *Idea.column_names

node(:members_actioned_count) { |idea| idea.members_actioned.size  }

child(@sorted_idea_actions => :idea_actions) { extends('ideas/idea_action') }
child(:talks) { attributes *Talk.column_names }
child(:tags) { attributes *Tag.column_names }
