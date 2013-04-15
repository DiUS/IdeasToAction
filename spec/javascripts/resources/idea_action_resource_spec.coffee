describe 'IdeaActionResource', -> 
  IdeaActionResource = null

  beforeEach module 'Actionman'

  beforeEach inject (_IdeaActionResource_) ->
    IdeaActionResource = _IdeaActionResource_

  it 'should exist', ->
    expect(IdeaActionResource).not.toBeNull()

  it 'should be a resource', ->
    expect(IdeaActionResource.delete).toBeDefined()
    expect(IdeaActionResource.get).toBeDefined()

  it 'should query a mix', ->
    expect(IdeaActionResource.mix).toBeDefined()