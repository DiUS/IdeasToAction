describe 'EventResource', -> 
  EventResource = null

  beforeEach module 'Actionman'

  beforeEach inject (_EventResource_) ->
    EventResource = _EventResource_

  it 'should exist', ->
    expect(EventResource).not.toBeNull()

  it 'should be a resource', ->
    expect(EventResource.delete).toBeDefined()
    expect(EventResource.get).toBeDefined()

  it 'should query a mix', ->
    expect(EventResource.mix).toBeDefined()