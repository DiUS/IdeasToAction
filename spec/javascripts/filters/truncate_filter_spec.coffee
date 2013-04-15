describe 'truncate', -> 

  truncateFilter = null

  beforeEach module "Actionman"

  beforeEach inject ($filter) ->
    truncateFilter = $filter('truncate')

  it 'should exist', ->
    expect(truncateFilter).not.toBeNull()

  it 'should handle undefined', ->
    expect(truncateFilter(undefined)).toEqual('')

  it 'should not truncate if less than the number provided', ->
    expect(truncateFilter('aaron', 10)).toEqual('aaron')

  it 'should not truncate if length plus periods is the same length', ->
    expect(truncateFilter('aaron', 2)).toEqual('aaron')

  it 'should truncate to 10 if length is not provided', ->
    expect(truncateFilter('aaron is writing a filter')).toEqual('aaron i...')

  it 'should truncate if length is more than number provided', ->
    expect(truncateFilter('aaron is writing a filter', 15)).toEqual('aaron is wri...')