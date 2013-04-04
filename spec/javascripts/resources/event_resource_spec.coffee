describe 'EventResource', -> 
  EventResource = null

  beforeEach module 'Actionman'

  beforeEach inject (_EventResource_) ->
    EventResource = _EventResource_

  it 'should exist', ->
    expect(EventResource).not.toBeNull()

  it 'should be a resource', ->
    eventResource = new EventResource()
    expect(eventResource.$delete).toBeDefined()
    expect(eventResource.$get).toBeDefined()

  it 'should query a mix of events', ->
    eventResource = new EventResource()
    expect(eventResource.$mix).toBeDefined()