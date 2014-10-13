describe 'unique', ->

  uniqueFilter = null
  items = [{id: 1}, {id: 2}, {id: 3}, {id: 1}, {id: 3}]

  beforeEach module 'Actionman'

  beforeEach inject ($filter) -> uniqueFilter = $filter('unique')

  it 'should exist', ->
    expect(uniqueFilter).not.toBeNull()

  it 'should handle undefined', ->
    expect(uniqueFilter(undefined)).toEqual([])

  it 'should truncate the items list', ->
    expect(uniqueFilter(items, 'id').length).toEqual(3)

