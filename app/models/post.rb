class Post < ActiveRecord::Base
    belongs_to :user
    
    def get_freshness
       if self.created_at > DateTime.now.prev_day 
           "Go get some now!"
       elsif self.created_at > DateTime.now.prev_day.prev_day 
           "Getting stale"
       else
           "Not so fresh" 
       end
    end
end