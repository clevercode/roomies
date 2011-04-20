class AssignmentFactory

  def self.new(attributes)

    # if there are no assignees (bounties, freebies, gifts & wishes)
    if attributes[:assignees].blank?

      # if it has not been claimed (bounties & wishes)
      if attributes[:cost].nil?
        if attributes[:claimed_at].nil?
          Bounty.new(attributes)
        else
          Freebie.new(attributes)
        end
      else
        if attributes[:claimed_at].nil?
          Wish.new(attributes)
        else
          Gift.new(attributes)
        end
      end

    # if there are assignees
    else
      if attributes[:cost].nil?
        # tasc or chore
        if attributes[:frequency].blank?
          Tasc.new(attributes)
        else
          Chore.new(attributes)
        end

      else
        # expense or bill
        if attributes[:frequency].blank?
          Expense.new(attributes)
        else
          Bill.new(attributes)
        end
      end

    end

  end

end
