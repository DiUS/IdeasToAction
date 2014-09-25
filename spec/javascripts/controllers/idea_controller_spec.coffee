describe 'IdeaCtrl', -> 
  ideaData = { 
    description: 'Body language affects how others see us, but it may also change how we see ourselves.'
    action: ['action1', 'action2']
    talks: [{title: "The talk"}, {title: "The other talk"}]
  }

  scope = null
  $httpBackend = null

  beforeEach module 'Actionman'

  beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory, $navigate) ->
    $httpBackend = _$httpBackend_

    window.ENDPOINT = 'window_endpoint'

    $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1.json").
          respond(ideaData)
    $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1/show_idea_url").
          respond({idea_url: "http://bit.ly/15z4CPz"})

    scope = $rootScope.$new()
    $controller 'IdeaCtrl', { $scope: scope, $routeParams: { ideaId: 1 }, dataCache: $cacheFactory('fake cache'), $navigate }

  describe "#update", ->

    it 'should set the ideaId correctly', ->
      scope.update()
      $httpBackend.flush()
      expect(scope.ideaId).toEqual(1);

    it 'should create "idea" model obtained restfully', ->
      scope.update()
      expect(scope.idea).toBeUndefined()
      $httpBackend.flush()
      expect(scope.idea).toEqual(ideaData)

    it 'should generate a twitter url', ->
      scope.update()
      expect(scope.twitter).toBeUndefined()
      $httpBackend.flush()
      expect(scope.twitter.url).toEqual("https://twitter.com/intent/tweet?original_referer=#{window.ENDPOINT}&text=#{encodeURIComponent(scope.idea.talks[0].title)}&tw_p=tweetbutton&url=#{scope.idea_short_url}")

    it 'should expose an update method', ->
      expect(scope.update).toBeDefined()

    it 'should execute a callback within update if one is given', ->
      callback = jasmine.createSpy 'callback'
      scope.update(callback)
      $httpBackend.flush()
      expect(callback).toHaveBeenCalled()

    it 'should set reactions on scope, based on interactions which habe reaction text', ->
      scope.update()
      $httpBackend.flush()
      expect(scope.idea.reactions.length).toEqual(2)
      expect(scope.idea.reactions[0]).toEqual({reaction_text: 'some text'})
      expect(scope.idea.reactions[1]).toEqual({reaction_text: 'some more text'})

  describe '#tweet', ->
    composeTweet = null
    isTwitterAvailable = null

    beforeEach ->
      scope.twitter = {}
      composeTweet = jasmine.createSpy('composeTweet')
      isTwitterAvailable = jasmine.createSpy('isTwitterAvailable').andCallFake (response) -> response()

      window.plugins = 
        twitter: 
          isTwitterAvailable: isTwitterAvailable
          composeTweet: composeTweet

    describe 'when not Apple', ->
      beforeEach ->
        scope.twitter.isApple = undefined
        scope.tweet()

      it 'should not do anything', ->
        expect(isTwitterAvailable).not.toHaveBeenCalled()
        expect(composeTweet).not.toHaveBeenCalled()

    describe 'when is Apple', ->
      beforeEach ->
        scope.twitter.isApple = true
        scope.tweet()

      it 'should check if twitter is available', ->
        expect(isTwitterAvailable).toHaveBeenCalled()

      it 'should check compose the tweet', ->
        expect(composeTweet).toHaveBeenCalled()