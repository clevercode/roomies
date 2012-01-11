beforeEach ->

  this.addMatchers

    toBeInstanceOf: (constructor)->
      this.actual instanceof constructor
