describe 'Flash', ->
  describe '#make', ->
    it 'should be an instance of Flash.$', ->
      flash = Roomies.Flash.make()
      expect(flash).toBeInstanceOf(Roomies.Flash.$)

    it 'should accept text', ->
      flash = Roomies.Flash.make(text: 'Test Text')
      expect(flash).toHaveText(/Test Text/)

    it 'should accept a type', ->
      flash = Roomies.Flash.make(type: 'alert')
      expect(flash).toHaveClass('flash_alert')

    it 'should default to a notice', ->
      flash = Roomies.Flash.make()
      expect(flash).toHaveClass('flash_notice')

  describe '$', ->
    beforeEach ->
      @parent = $('<div />', id: 'flashes').appendTo('body')
      @flash = Roomies.Flash.make(text: 'Test Notice', type: 'notice')

    afterEach ->
      @parent.remove()

    it 'should be jQuery subclass', ->
      expect(@flash.jquery).toBeDefined()
      expect(@flash instanceof Roomies.Flash.$).toBeTruthy()

    describe '#openIn', ->
      it 'should animate the action', ->
        @flash.openIn(@parent)
        expect(@flash).toBe(':animated')

      it 'should call the passed in callback after animating', ->
        callback = sinon.spy()
        @flash.openIn(@parent,callback)
        @flash.stop(true,true) 
        expect(callback.called).toBeTruthy()

      it 'should be visible after animating', ->
        @flash.openIn(@parent)
        @flash.stop(true,true) 
        expect(@flash).toBeVisible()


    describe '#close', ->
      it 'should not be above the page after animating', ->
        @flash.openIn(@parent)
        @flash.stop(true,true) 
        @flash.close()
        @flash.stop(true,true) 
        expect(@flash.position().top).toBe(-@flash.outerHeight())

      it 'should call the callback after animating', ->
        callback = sinon.spy()
        @flash.openIn(@parent)
        @flash.stop(true,true) 
        @flash.close(callback)
        @flash.stop(true,true) 
        expect(callback.called).toBeTruthy()

      it 'should animate out the action', ->
        @flash.openIn(@parent)
        @flash.stop(true,true) 
        @flash.close()
        expect(@flash).toBe(':animated')


    describe '#sticky', ->
      it 'should add the sticky class', ->
        @flash.sticky()
        expect(@flash).toHaveClass('sticky')

    describe '#isSticky', ->
      it 'should return true when sticky', ->
        @flash.sticky()
        expect(@flash.isSticky()).toBeTruthy()

      it 'should return false when not sticky', ->
        expect(@flash.isSticky()).toBeFalsy()
