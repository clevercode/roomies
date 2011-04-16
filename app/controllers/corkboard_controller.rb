class CorkboardController < ApplicationController
  def index
    @user = current_user
    @freebies = Freebie.all
    @bounties = Bounty.all
    @gifts = Gift.all
    @wishes = Wish.all

    @tasks = Tasc.all
    @expenses = Expense.all
    @bills = Bill.all
    @chores = Chore.all

    @things = []
    @things = @tasks + 
              @expenses
  end
end
