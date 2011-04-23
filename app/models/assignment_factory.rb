class AssignmentFactory

  def self.new(attributes)
    # before calling new we find out what model to use
    # based on the attributes received
    class_for(attributes).new(attributes)
  end

  def self.class_for(attributes)

    # if there are no assignees (bounties, freebies, gifts & wishes)
    if attributes[:assignees].blank?

      # if it has not been claimed (bounties & wishes)
      if attributes[:cost].nil?
        if attributes[:claimed_at].nil?
          Bounty
        else
          Freebie
        end
      else
        if attributes[:claimed_at].nil?
          Wish
        else
          Gift
        end
      end

    # if there are assignees
    else
      if attributes[:cost].nil?
        # tasc or chore
        if attributes[:frequency].blank?
          Tasc
        else
          Chore
        end

      else
        # expense or bill
        if attributes[:frequency].blank?
          Expense
        else
          Bill
        end
      end

    end
  end


end
