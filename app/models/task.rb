class Task
  include Mongoid::Document

  include Trait::Completable
  include Trait::Assignable
  include Trait::Commissionable
  include Trait::Schedulable
end
