PasswordGenerator = @Roomies.utils.PasswordGenerator

describe 'PasswordGenerator', ->
  describe '#generate', ->
    it 'returns a string of specified length', ->
      expect(PasswordGenerator.generate(5).length).toEqual(5)
      expect(PasswordGenerator.generate(16).length).toEqual(16)
