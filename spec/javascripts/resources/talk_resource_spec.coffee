describe 'TalkResource', -> 
  TalkResource = null

  beforeEach module 'Actionman'

  beforeEach inject (_TalkResource_) ->
    TalkResource = _TalkResource_

  it 'should exist', ->
    expect(TalkResource).not.toBeNull()

  it 'should be a resource', ->
    expect(TalkResource.delete).toBeDefined()
    expect(TalkResource.get).toBeDefined()

  it 'should query a mix', ->
    expect(TalkResource.mix).toBeDefined()