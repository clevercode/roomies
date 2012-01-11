describe 'FlashesView', ->
  beforeEach ->
    @flashesView = new Roomies.FlashesView($('<div id="flashes"/>').appendTo('body'))

  afterEach ->
    @flashesView.$element.remove()

  describe '#alert', ->
    beforeEach ->
      @flash = @flashesView.alert('Alert Text')

    it 'should be an instance of Flash.$', ->
      expect(@flash).toBeInstanceOf(Roomies.Flash.$)
    
    it 'should have a class of `flash_alert`', ->
      expect(@flash).toHaveClass('flash_alert')

    it 'should have the specified text', ->
      expect(@flash).toHaveText(/Alert Text/)


  describe '#notice', ->
    beforeEach ->
      @flash = @flashesView.notice('Notice Text')

    it 'should be an instance of Flash.$', ->
      expect(@flash).toBeInstanceOf(Roomies.Flash.$)
    
    it 'should have a class of `flash_notice`', ->
      expect(@flash).toHaveClass('flash_notice')

    it 'should have the specified text', ->
      expect(@flash).toHaveText(/Notice Text/)
