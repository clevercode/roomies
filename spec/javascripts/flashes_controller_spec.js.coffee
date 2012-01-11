describe 'FlashesController', ->
  beforeEach ->
    @flashes = new Roomies.FlashesController($('<div id="flashes"/>').appendTo('body'))

  afterEach ->
    @flashes.$element.remove()

  describe '#alert', ->
    beforeEach ->
      @flash = @flashes.alert('Alert Text')

    it 'should be an instance of Flash.$', ->
      expect(@flash).toBeInstanceOf(Roomies.Flash.$)
    
    it 'should have a class of `flash_alert`', ->
      expect(@flash).toHaveClass('flash_alert')

    it 'should have the specified text', ->
      expect(@flash).toHaveText(/Alert Text/)


  describe '#notice', ->
    beforeEach ->
      @flash = @flashes.notice('Notice Text')

    it 'should be an instance of Flash.$', ->
      expect(@flash).toBeInstanceOf(Roomies.Flash.$)
    
    it 'should have a class of `flash_notice`', ->
      expect(@flash).toHaveClass('flash_notice')

    it 'should have the specified text', ->
      expect(@flash).toHaveText(/Notice Text/)
