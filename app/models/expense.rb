class Expense
  include Mongoid::Document

  include Trait::Completable
  include Trait::Commissionable
  include Trait::Assignable
  include Trait::Schedulable
  include Trait::Payable
end

