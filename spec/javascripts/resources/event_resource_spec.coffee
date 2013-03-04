describe 'Actionman', ->

  beforeEach(angular.mock.module('Actionman'))

  describe 'EventResource', -> 
    EventResource = null

    beforeEach(inject(
      ['EventResource', (er) ->
        EventResource = er
      ]
    ))

    it 'should exist', ->
      expect(EventResource).not.toBeNull()

    it 'should be a resource', ->
      eventResource = new EventResource()
      expect(eventResource.$save).toBeDefined()
      expect(eventResource.$update).toBeDefined()
      expect(eventResource.$delete).toBeDefined()
      expect(eventResource.$get).toBeDefined()