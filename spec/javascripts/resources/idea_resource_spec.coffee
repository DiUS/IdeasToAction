describe 'IdeaResource', -> 
  IdeaResource = null

  beforeEach module 'Actionman'

  beforeEach inject (_IdeaResource_) ->
    IdeaResource = _IdeaResource_

  it 'should exist', ->
    expect(IdeaResource).not.toBeNull()

  it 'should be a resource', ->
    expect(IdeaResource.delete).toBeDefined()
    expect(IdeaResource.get).toBeDefined()

  it 'should query a mix', ->
    expect(IdeaResource.mix).toBeDefined()